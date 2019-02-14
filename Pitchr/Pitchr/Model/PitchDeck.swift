//
//  Pitch.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 14/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

struct PitchDeck: ProducesCardViewModel {
    var pitchName: String
    var name: String
    var summary: String
    var imageNames: [String]
    
    func toCardViewModel() -> CardViewModel {
        let informationAttributedText = generateAttributedText()
        return CardViewModel(imageNames: imageNames, attributedString: informationAttributedText, textAlignment: .left)
    }
    
    fileprivate func generateAttributedText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: pitchName, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSAttributedString(string: " by \(name)", attributes: [.font: Appearance.appFont(with: 18, weight: .bold)]))
        attributedText.append(NSAttributedString(string: "\n\(summary)", attributes: [.font: Appearance.appFont(with: 14, weight: .regular)]))
        return attributedText
    }
}
