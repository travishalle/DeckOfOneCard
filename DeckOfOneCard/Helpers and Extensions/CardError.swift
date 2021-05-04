//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by Travis Halle on 5/4/21.
//

import UIKit

enum CardError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach the server"
        case .thrownError(let error):
            print(error.localizedDescription)
            return error.localizedDescription
        case .noData:
            return "The server responded with no data"
        case .unableToDecode:
            return "The server responded with bad data. Blame the back end team."
        }
    }
}//End of enum
