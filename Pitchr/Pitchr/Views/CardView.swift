//
//  CardView.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 12/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    fileprivate let cardImageView = UIImageView(image: #imageLiteral(resourceName: "test"))
    
    //Configurations
    fileprivate let swipeThreshold: CGFloat = 120
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        clipsToBounds = true
        
        addSubview(cardImageView)
        cardImageView.fillSuperview()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        switch gesture.state {
        case .changed:
            handleChanged(translation)
        case .ended:
            handleEnded(translation)
        default: ()
        }
    }
    
    fileprivate func handleChanged(_ translation: CGPoint) {
        //convert radians to degrees
        let degree: CGFloat = translation.x / 20
        let angle = degree * .pi / 180
        
        let rotationalTransform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransform.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded(_ translation: CGPoint) {
        let translationDirection: CGFloat = translation.x > 0 ? 1 : -1
        let shouldDismissCard = translation.x > swipeThreshold ? true : false
        
        UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                self.frame = CGRect(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
            } else {
                self.transform = .identity
            }
        }) { (_) in
            self.transform = .identity
            self.removeFromSuperview()
//            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
