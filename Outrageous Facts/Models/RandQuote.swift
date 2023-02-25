//
//  RandQuote.swift
//  Outrageous Facts
//
//  Created by John Smith on 2/20/23.
//

import Foundation

class RandQuote {
    
    func getQuote() -> String {
        let randIdx = Int.random(in: 0...Quote.sampleData.count-1)
        let quoteData: [Quote] = Quote.sampleData
        let quote: String = quoteData[randIdx].quote
        return quote
    }
}
