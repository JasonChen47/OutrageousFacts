//
//  Quote.swift
//  Outrageous Facts
//
//  Created by John Smith on 1/9/23.
//

import Foundation

struct Quote: Identifiable {
    let id: UUID
    var quote: String
    
    init(id: UUID = UUID(), quote: String) {
        self.id = id
        self.quote = quote
    }
}

extension Quote {
    static let sampleData: [Quote] =
    [
        Quote(quote: "Columbus sailed the ocean blue in 1492"),
        Quote(quote: "Tesla liked pigeons"),
        Quote(quote: "The Wright brothers originally worked on bicycles"),
        Quote(quote: "Galileo had a daughter"),
        Quote(quote: "Marie Curie's daughter loved to play piano"),
        Quote(quote: "John D. Rockefeller had a goal to live to 100 years old"),
        Quote(quote: "The noncanonical Gospel of Thomas contains Jesus's sayings"),
        Quote(quote: "England and Zanzibar's war lasted 38 minutes"),
        Quote(quote: "Einstein declined becoming Israel's president in 1952"),
        Quote(quote: "Mona Lisa could be an anagram for Mon Salai"),
        Quote(quote: "Marie Curie is the first person to win the Nobel Prize twice"),
        Quote(quote: "Africa has never hosted an Olympics"),
        Quote(quote: "666 likely refers to Nero's number in Hebrew"),
        Quote(quote: "Lincoln established the Secret Service hours before being killed"),
        Quote(quote: "Marco Polo's story was written by a friend in jail"),
        Quote(quote: "Rockefeller founded the General Education Board"),
        Quote(quote: "Columbus reintroduced horses to North America in the 15th century"),
        Quote(quote: "The Tower of Pisa has been leaning for all its existence"),
        Quote(quote: "Tobacco was taken to Europe in 1528"),
        Quote(quote: "Mummification took 40 days to perform"),
        Quote(quote: "Ancient Egyptian shabtis were believed to serve the dead"),
        Quote(quote: "Frogs were a symbol of life and fertility in ancient Egypt"),
        Quote(quote: "Byzantines would sever people's noses to prevent them from ruling"),
        Quote(quote: "Jimmu, Japan's first emperor, was born in 660 BCE"),
        Quote(quote: "")
    ]
}
