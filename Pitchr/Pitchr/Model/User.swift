//
//  User.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 13/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

struct User {
    let name: String
    let age: Int
    let proffesion: String
    let imageName: String
    
    func toCardViewModel() -> CardViewModel {
        let informationAttributedText = generateAttributedText()
        return CardViewModel(imageName: imageName, attributedString: informationAttributedText, textAlignment: .left)
    }
    
    fileprivate func generateAttributedText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSAttributedString(string: "  \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedText.append(NSAttributedString(string: "\n\(proffesion)", attributes: [.font: UIFont.systemFont(ofSize: 22, weight: .regular)]))
        return attributedText
    }
}
