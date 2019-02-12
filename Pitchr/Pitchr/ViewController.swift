//
//  ViewController.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 12/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let redView = UIView()
        redView.backgroundColor = .red
        redView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let blueView = UIView()
        redView.backgroundColor = .blue
        
        let greenView = UIView()
        redView.backgroundColor = .green
        greenView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        
        let topStackView = UIStackView(arrangedSubviews: [])
        topStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let bottomStackView = HomeBottomControlsStackView(arrangedSubviews: [])
        bottomStackView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        let containerStackView = UIStackView(arrangedSubviews: [topStackView, blueView, bottomStackView])
        containerStackView.axis = .vertical
        
        view.addSubview(containerStackView)
        containerStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }


}

