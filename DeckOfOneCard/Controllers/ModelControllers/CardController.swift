//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Travis Halle on 5/4/21.
//

import UIKit

class CardController {
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/")
    
    static func fetchCard(completion: @escaping (Result<Card, CardError>) -> Void) {
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let urlParameters = [URLQueryItem(name: "count", value: "1")]
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)

        urlComponents?.queryItems = urlParameters
        
        guard let finalURL = urlComponents?.url else { return completion(.failure(.invalidURL)) }
        print(finalURL)
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("Status code: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                guard let card = topLevelObject.cards.first else {return completion(.failure(.unableToDecode))}
                completion(.success(card))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result <UIImage, CardError>) -> Void) {
        let url = card.image
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("Image status code: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let cardImage = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            
            completion(.success(cardImage))
        }.resume()
    }
}//End of class
