//
//  SocialButton.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 13/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class SocialButton: UIButton {
    
    private var leftPadding: CGFloat
    
    init(frame: CGRect, leftPadding: CGFloat) {
        self.leftPadding = leftPadding
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: leftPadding)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
