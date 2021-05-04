//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Travis Halle on 5/4/21.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Properties
    var card: Card?
    
    @IBAction func drawButtonPressed(_ sender: Any) {
        
        CardController.fetchCard { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let card):
                    self?.fetchImageAndUpdateViews(for: card)
                    self?.card = card
                    self?.cardLabel.text = "\(card.value) of \(card.suit)"
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    func fetchImageAndUpdateViews(for card: Card) {
        
        CardController.fetchImage(for: card) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.cardImageView.image = image
                case .failure(let error):
                    self.cardImageView.image = UIImage(systemName: "xmark.rectangle.portrait")
                    print(error.localizedDescription)
                }
            }
        }
    }
}//End of class
