//
//  CardViewModel.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 13/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    fileprivate var pageIndex = 0 {
        didSet {
            let image = UIImage(named: imageNames[pageIndex])
            pageIndexObserver?(pageIndex, image)
        }
    }
    
    var pageIndexObserver: ((Int ,UIImage?) -> ())?
    
    
    func advanceToNextPage() {
        pageIndex = min(pageIndex + 1, imageNames.count - 1)
    }
    
    func goToPreviousPage() {
        pageIndex = max(0, pageIndex - 1)
    }
}
