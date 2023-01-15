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
        Quote(quote: "Catholics massacred around 15,000 Protestants in the 16th century"),
        Quote(quote: "Ghengis Khan means 'Universal Ruler'"),
        Quote(quote: "Tesla would have vivid visions of inventions"),
        Quote(quote: "The Byzantines learned silk-making from two monks who smuggled silkworms"),
        Quote(quote: "Of the 70,000 rebels led by Spartacus, 6,000 were crucified"),
        Quote(quote: "Around 1 CE, the Roman Empire comprised 1/7 of the world's population"),
        Quote(quote: "Pope Leo III proclaimed Charlemagne king of the Holy Roman Empire"),
        Quote(quote: "Teotihuacan had 200,000 people at its peak"),
        Quote(quote: "In 125 CE, Chinese eunuchs murdered Emperor Shaodi"),
        Quote(quote: "The Roman military used thin wooden tablets for record-keeping"),
        Quote(quote: "Romans used metal strigils at their baths to help scrape off dirt"),
        Quote(quote: "Roman emperors were frequently murdered"),
        Quote(quote: "Emperor Ashoka's daughter spread Buddhism to Sri Lanka")
    ]
}
