//
//  APIRequest.swift
//  Outrageous Facts
//
//  Created by John Smith on 2/20/23.
//

import Foundation
import SwiftUI
import UIKit

class APIRequest {
    var quoteArr: [String]
    
    init(quoteArr: [String]) {
        self.quoteArr = quoteArr
    }
    
    // To collect the quote from the array if it is populated. If it is not, take from the local storage of quotes.
    func quickQuote() -> String {
        var tempQuote = ""
        self.checkFillArr()
        if self.quoteArr.count > 0 {
            tempQuote = quoteArr[0]
            self.quoteArr.removeFirst()
            print("12876")
        }
        else {
            tempQuote = RandQuote.getQuote()
            print("57623")
        }
        return tempQuote
    }
    
    // Function to check if array is filled with 3 facts. If it is not, add one fact to the array.
    func checkFillArr() {
        if self.quoteArr.count < 20 {
            Task {
                // Perform API request if no errors
                do {
                    let quote = try await self.getQuote()
                    self.quoteArr.append(quote)
                }
                // Assign the other quote if there's an error
                catch {
                    print("array error")
                }
            }
        }
        print("The quoteArr count: \(self.quoteArr.count)")
    }
    
    // Function to allow for try await call
    func getQuote() async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            getQuote { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let quote):
                    continuation.resume(returning: quote)
                }
            }
        }
    }
    
    // Main function to get quote from API
    func getQuote(completion: @escaping (Result<String, Error>)->Void) {
        
        // Use URL with random month, day, and index into the array of facts
        let randMonth = String(Int.random(in: 1...12))
        let randDay = String(Int.random(in: 1...28))
        let randIdx = Int.random(in: 0...10)
        let url = URL(string: "http://history.muffinlabs.com/date/" + randMonth + "/" + randDay)!
        
        // Start the async work
        DispatchQueue.global(qos: .background).async {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                do {
                    // Catch any errors
                    if let error = error {
                        completion(.failure((error)))
                    }
                    else {
                        // Read the data. If no data, return an empty string.
                        guard let data = data else {
                            DispatchQueue.main.async {
                                completion(.success(""))
                            }
                            return
                        }
                        // JSON parse the data and return it
                        let codedData = data
                        let decodedData: JSONData = try JSONDecoder().decode(JSONData.self, from: codedData)
                        let wholeFact = decodedData.data.Events[randIdx].year + ": " + decodedData.data.Events[randIdx].text
                        DispatchQueue.main.async {
                            completion(.success(wholeFact))
                        }
                    }
                }
                // Catch any additional errors
                catch {
                    DispatchQueue.main.async {
                        print(error)
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
}
