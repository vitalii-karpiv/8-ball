//
//  Answer.swift
//  8-Ball
//
//  Created by newbie on 23.01.2022.
//

import Foundation

struct Answer: Decodable {
    var magic: Magic
}

struct Magic: Decodable {
    var answer: String
}
