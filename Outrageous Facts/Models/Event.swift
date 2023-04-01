//
//  Event.swift
//  Outrageous Facts
//
//  Created by John Smith on 2/20/23.
//

import Foundation

struct Event: Codable {
    struct linkDuo: Codable {
        var title: String
        var link: String
    }
    var year: String
    var text: String
    var html: String
    var no_year_html: String
    var links: [linkDuo]
}

