//
//  EmailSignInView.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 13/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class EmailSignInView: UIView {
    
    let loginStateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Appearance.appFont(with: 15, weight: .bold)
        button.isEnabled = false
        return button
    }()
    
    let registerStateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("REGISTER", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = Appearance.appFont(with: 15, weight: .bold)
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .lightGray
        label.font = Appearance.appFont(with: 12, weight: .bold)
        label.sizeToFit()
        label.isHidden = true
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.font = Appearance.appFont(with: 14, weight: .bold)
        tf.isHidden = true
        tf.tintColor = .appGreenTwo
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    let nameBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        view.layer.cornerRadius = 0.5
        view.isHidden = true
        return view
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = .lightGray
        label.font = Appearance.appFont(with: 12, weight: .bold)
        label.sizeToFit()
        return label
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.font = Appearance.appFont(with: 14, weight: .bold)
        tf.keyboardType = .emailAddress
        tf.tintColor = .appGreenTwo
        return tf
    }()
    
    let emailBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        view.layer.cornerRadius = 0.5
        return view
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .lightGray
        label.font = Appearance.appFont(with: 12, weight: .bold)
        label.sizeToFit()
        return label
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.font = Appearance.appFont(with: 14, weight: .bold)
        tf.isSecureTextEntry = true
        tf.tintColor = .appGreenTwo
        return tf
    }()
    
    let passwordBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        view.layer.cornerRadius = 0.5
        return view
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "rightarrow").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .appGreenTwo
        button.layer.cornerRadius = 12
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 12
        isHidden = true
        alpha = 0
        setupViews()
    }
    
    fileprivate func setupViews() {
        let switchStackView = UIStackView(arrangedSubviews: [loginStateButton, registerStateButton])
        switchStackView.axis = .horizontal
        switchStackView.distribution = .fillEqually
        switchStackView.isLayoutMarginsRelativeArrangement = true
        switchStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        addSubview(switchStackView)
        switchStackView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 16, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 40))
        
        addSubview(signInButton)
        signInButton.anchor(top: nil, leading: nil, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 16, right: 0), size: .init(width: 80, height: 40))
        signInButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        let textFieldStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField])
        textFieldStackView.spacing = 35
        textFieldStackView.distribution = .fillEqually
        textFieldStackView.axis = .vertical
        
        addSubview(textFieldStackView)
        textFieldStackView.anchor(top: switchStackView.bottomAnchor, leading: self.leadingAnchor, bottom: signInButton.topAnchor, trailing: self.trailingAnchor, padding: .init(top: 36, left: 18, bottom: 22, right: 18))
        
        addSubview(nameLabel)
        nameLabel.anchor(top: nil, leading: nameTextField.leadingAnchor, bottom: nameTextField.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: -5, right: 0))
        addSubview(emailLabel)
        emailLabel.anchor(top: nil, leading: emailTextField.leadingAnchor, bottom: emailTextField.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: -5, right: 0))
        addSubview(passwordLabel)
        passwordLabel.anchor(top: nil, leading: passwordTextField.leadingAnchor, bottom: passwordTextField.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: -5, right: 0))
        
        addSubview(nameBottomLine)
        nameBottomLine.anchor(top: nameTextField.bottomAnchor, leading: nameTextField.leadingAnchor, bottom: nil, trailing: nameTextField.trailingAnchor, padding: .init(top: -2, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
        addSubview(emailBottomLine)
        emailBottomLine.anchor(top: emailTextField.bottomAnchor, leading: emailTextField.leadingAnchor, bottom: nil, trailing: emailTextField.trailingAnchor, padding: .init(top: -2, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
        addSubview(passwordBottomLine)
        passwordBottomLine.anchor(top: passwordTextField.bottomAnchor, leading: passwordTextField.leadingAnchor, bottom: nil, trailing: passwordTextField.trailingAnchor, padding: .init(top: -2, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
