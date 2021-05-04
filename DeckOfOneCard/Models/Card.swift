//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Travis Halle on 5/4/21.
//

import Foundation

struct Card: Decodable {
    let value: String
    let suit: String
    let image: URL
}//End of struct

struct TopLevelObject: Decodable {
    let cards: [Card]
}//End of struct
