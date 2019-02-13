//
//  HomeTopNavigationStackView.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 12/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class HomeTopNavigationStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }
    
    //MARK:- Fileprivate
    
    fileprivate func setupStackView() {
        addArrangedSubview(UIView())
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
