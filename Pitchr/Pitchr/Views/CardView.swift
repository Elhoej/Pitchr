//
//  CardView.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 12/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var cardViewModel: CardViewModel! {
        didSet {
            cardImageView.image = UIImage(named: cardViewModel.imageNames.first ?? "")
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
            
            (0..<cardViewModel.imageNames.count).forEach { (_) in
                let barCell = UIView()
                barCell.layer.cornerRadius = 2
                barCell.backgroundColor = barCellDefaultColor
                barStackView.addArrangedSubview(barCell)
            }
            barStackView.arrangedSubviews.first?.backgroundColor = .white
        }
    }
    
    fileprivate let cardImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    fileprivate let gradientLayer = CAGradientLayer()
    
    fileprivate let barStackView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.spacing = 4
        return sv
    }()
    
    fileprivate let informationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    //Configurations
    fileprivate let swipeThreshold: CGFloat = 120
    fileprivate let barCellDefaultColor = UIColor(white: 0, alpha: 0.3)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardView()
        setupViews()
    }
    
    fileprivate func setupCardView() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        clipsToBounds = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    fileprivate var pageIndex = 0
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: nil)
        let shouldAdvance = location.x > frame.width / 2 ? true : false
        if shouldAdvance {
            pageIndex = min(pageIndex + 1, cardViewModel.imageNames.count - 1)
        } else {
            pageIndex = max(0, pageIndex - 1)
        }
        
        let imageName = cardViewModel.imageNames[pageIndex]
        cardImageView.image = UIImage(named: imageName)
        barStackView.arrangedSubviews.forEach({ $0.backgroundColor = barCellDefaultColor })
        barStackView.arrangedSubviews[pageIndex].backgroundColor = .white
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
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
        let shouldDismissCard = abs(translation.x) > swipeThreshold ? true : false
        
        UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                self.frame = CGRect(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
            } else {
                self.transform = .identity
            }
        }) { (_) in
            self.transform = .identity
            if shouldDismissCard {
                self.removeFromSuperview()
            }
        }
    }
    
    fileprivate func setupViews() {
        addSubview(cardImageView)
        cardImageView.fillSuperview()
        setupGradientLayer()
        
        addSubview(barStackView)
        barStackView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
    }
    
    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.6, 1.1]
        gradientLayer.frame = self.bounds
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
