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
    var linkArr: [String]
    
    init(quoteArr: [String], linkArr: [String]) {
        self.quoteArr = quoteArr
        self.linkArr = linkArr
    }
    
    // To just get the string from a API quote
    func getQuoteString(completion: @escaping ([String])->()){
        Task {
            do {
                let quote = try await self.getQuote()
                let fact = quote[0]
                let link = quote[1]
                completion([fact, link])
            }
            // Assign the other quote if there's an error
            catch {
                let fact = RandQuote.getQuote()
                completion([fact, ""])
            }
        }
    }
    
    // To collect the quote from the array if it is populated. If it is not, take from the local storage of quotes.
    func quickQuote() {
        self.addFact()
    }
    
    // Function to fetch from API add one fact to the end of the array. If there's an error, add the local fact.
    func addFact() {
        Task {
            // Perform API request if no errors
            let oldArrLength = self.quoteArr.count
            do {
                let quote = try await self.getQuote()
                self.quoteArr.append(quote[0])
                self.linkArr.append(quote[1])
            }
            // Assign the other quote if there's an error
            catch {
                let quote = RandQuote.getQuote()
                self.quoteArr.append(quote)
                self.linkArr.append("")
            }
            let newArrLength = self.quoteArr.count
            if oldArrLength == newArrLength {
                let quote = RandQuote.getQuote()
                self.quoteArr.append(quote)
                self.linkArr.append("")
            }
        }
//        print("The quoteArr count: \(self.quoteArr.count)")
    }
    
    // Function to allow for try await call
    func getQuote() async throws -> [String] {
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
    func getQuote(completion: @escaping (Result<[String], Error>)->Void) {
        
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
                                completion(.success(["", ""]))
                            }
                            return
                        }
                        // JSON parse the data and return it
                        let codedData = data
                        let decodedData: JSONData = try JSONDecoder().decode(JSONData.self, from: codedData)
                        let wholeFact = decodedData.data.Events[randIdx].year + ": " + decodedData.data.Events[randIdx].text
                        let factURL = decodedData.data.Events[randIdx].links[0].link
                        DispatchQueue.main.async {
                            completion(.success([wholeFact, factURL]))
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
