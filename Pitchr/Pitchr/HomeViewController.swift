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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        
        setupDummyCards()
    }
    
    //MARK:- Fileprivate
    
    fileprivate func setupDummyCards() {
        (0..<10).forEach { (_) in
            let cardView = CardView()
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

