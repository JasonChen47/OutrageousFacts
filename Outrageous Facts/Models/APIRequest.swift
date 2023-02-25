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
    
    // Function to allow for try await call
    static func getQuote() async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            getQuote { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let scrums):
                    continuation.resume(returning: scrums)
                }
            }
        }
    }
    
    // Main function to get quote from API
    static func getQuote(completion: @escaping (Result<String, Error>)->Void) {
        
        // Use URL with random month and day
        let randMonth = String(Int.random(in: 1...12))
        let randDay = String(Int.random(in: 1...28))
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
                        let wholeFact = decodedData.data.Events[0].year + ": " + decodedData.data.Events[0].text
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
