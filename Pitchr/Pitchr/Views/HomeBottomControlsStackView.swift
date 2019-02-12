//
//  HomeBottomControlsStackView.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 12/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
