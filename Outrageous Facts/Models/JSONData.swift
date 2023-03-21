//
//  JSONData.swift
//  Outrageous Facts
//
//  Created by John Smith on 2/20/23.
//

import Foundation

struct JSONData: Codable {
    struct data: Codable {
        var Events: [Event]
    }
    var date: String
    var url: URL
    var data: data
}


