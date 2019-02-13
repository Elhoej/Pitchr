//
//  ViewController.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 12/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - Global Variables
    
    let topStackView = HomeTopNavigationStackView()
    let bottomStackView = HomeBottomControlsStackView()
    let cardsDeckView = UIView()
    
    let cardViewModels = [
        User(name: "Kelly", age: 23, proffesion: "Music DJ", imageName: "test").toCardViewModel(),
        User(name: "Jane", age: 18, proffesion: "Teacher", imageName: "test2").toCardViewModel()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        
        setupDummyCards()
    }
    
    //MARK:- Fileprivate
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (card) in
            let cardView = CardView()
            cardView.cardImageView.image = UIImage(named: card.imageName)
            cardView.informationLabel.attributedText = card.attributedString
            cardView.informationLabel.textAlignment = card.textAlignment
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    fileprivate func setupViews() {
        let containerStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, bottomStackView])
        containerStackView.axis = .vertical
        containerStackView.isLayoutMarginsRelativeArrangement = true
        containerStackView.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        view.addSubview(containerStackView)
        containerStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        containerStackView.bringSubviewToFront(cardsDeckView)
    }
}

