//
//  ViewController.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 12/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    //MARK: - Global Variables
    
    let topStackView = HomeTopNavigationStackView()
    let bottomStackView = HomeBottomControlsStackView()
    let cardsDeckView = UIView()
    
    //For testing only
    let cardViewModels: [CardViewModel] = {
        let producers = [
            PitchDeck(pitchName: "Uber", name: "Garrett Camp", summary: "Request a ride at the push of a button", imageNames: ["uber-1", "uber-2", "uber-3"]),
            Advertiser(title: "Good for life!", brandName: "Dr Pepper", posterPhotoName: "drpepper"),
            PitchDeck(pitchName: "Too Good To Go", name: "Jamie Crummie", summary: "Red lækker mad og bekæmp madspild", imageNames: ["tgtg-1", "tgtg-2", "tgtg-3"])
        ] as [ProducesCardViewModel]
        
        let viewModels = producers.map({ return $0.toCardViewModel() })
        return viewModels
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupTopNav()
        
        setupDummyCards()
    }
    
    //MARK: - Fileprivate
    
    //testing...
    fileprivate func fetchUsersFromFirestore() {
        Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
            if let error = error {
                NSLog("Failed to fetch users from Firestore: \(error)")
                return
            }
            
            snapshot?.documents.forEach({ (docSnap) in
                let userDictionary = docSnap.data()
                let user = User(dictionary: userDictionary)
                print(user.name)
            })
        }
    }
    
    fileprivate func setupTopNav() {
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
    }
    
    @objc fileprivate func handleSettings() {
        let loginViewController = LoginViewController()
        present(loginViewController, animated: true, completion: nil)
    }
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (card) in
            let cardView = CardView()
            cardView.cardViewModel = card
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

