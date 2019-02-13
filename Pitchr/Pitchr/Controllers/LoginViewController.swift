//
//  LoginViewController.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 13/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    fileprivate var isInLoginState = true
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pitchr"
        label.textColor = .white
        label.font = Appearance.appFont(with: 48, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let continueWithLabel: UILabel = {
        let label = UILabel()
        label.font = Appearance.appFont(with: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Continue with"
        return label
    }()
    
    fileprivate let emailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Email", for: .normal)
        button.titleLabel?.font = Appearance.appFont(with: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(handleEmail), for: .touchUpInside)
        return button
    }()
    
    fileprivate let googleButton: SocialButton = {
        let button = SocialButton(frame: .zero, leftPadding: 16)
        button.setImage(#imageLiteral(resourceName: "googleplus").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.setTitle("Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Appearance.appFont(with: 14, weight: .bold)
        button.backgroundColor = .googleOrange
        button.layer.cornerRadius = 12
        return button
    }()
    
    fileprivate let facebookButton: SocialButton = {
        let button = SocialButton(frame: .zero, leftPadding: 16)
        button.setImage(#imageLiteral(resourceName: "facebook").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.setTitle("Facebook", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Appearance.appFont(with: 14, weight: .bold)
        button.backgroundColor = .facebookBlue
        button.layer.cornerRadius = 12
        return button
    }()
    
    fileprivate let emailSignInView = EmailSignInView()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupGradientLayer()
        setupViews()
        setupEmailLoginView()
        setupKeyboardObservers()
        setupTapGesture()
    }
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc fileprivate func handleTap() {
        self.view.endEditing(true)
    }
    
    fileprivate func setupEmailLoginView() {
        emailSignInView.loginStateButton.addTarget(self, action: #selector(handleEmailSignInState), for: .touchUpInside)
        emailSignInView.registerStateButton.addTarget(self, action: #selector(handleEmailSignInState), for: .touchUpInside)
    }
    
    fileprivate func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleKeyboard(notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        self.containerBottomAnchor?.constant = notification.name == UIResponder.keyboardWillShowNotification ? -175 : -32
        
        UIView.animate(withDuration: duration, delay: 0, options:  UIView.AnimationOptions(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc fileprivate func handleEmailSignInState() {
        self.view.endEditing(true)
        isInLoginState = isInLoginState ? false : true
        emailSignInView.loginStateButton.isEnabled = isInLoginState ? false : true
        emailSignInView.registerStateButton.isEnabled = isInLoginState ? true : false
        emailSignInView.loginStateButton.setTitleColor(isInLoginState ? .black : .lightGray, for: .normal)
        emailSignInView.registerStateButton.setTitleColor(isInLoginState ? .lightGray : .black, for: .normal)
        
        emailSignInHeightAnchor?.constant = isInLoginState ? 280 : 352.5
        emailSignInView.nameTextField.isHidden = isInLoginState ? true : false
        emailSignInView.nameLabel.isHidden = isInLoginState ? true : false
        emailSignInView.nameBottomLine.isHidden = isInLoginState ? true : false
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc fileprivate func handleEmail() {
        self.emailSignInView.isHidden = false
        titleCenterYAnchor?.isActive = false
        titleBottomAnchor?.isActive = true
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.emailSignInView.alpha = 1
            self.continueWithLabel.alpha = 0
            self.emailButton.setTitle("Or login with", for: .normal)
            self.emailButton.setTitleColor(.white, for: .normal)
            self.emailButton.backgroundColor = .clear
            self.emailButton.isEnabled = false
        }
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.appGreenTwo.cgColor, UIColor.appGreenOne.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
    }
    
    fileprivate var titleBottomAnchor: NSLayoutConstraint?
    fileprivate var titleCenterYAnchor: NSLayoutConstraint?
    fileprivate var emailSignInHeightAnchor: NSLayoutConstraint?
    fileprivate var containerBottomAnchor: NSLayoutConstraint?
    
    fileprivate func setupViews() {
        let socialStackView = UIStackView(arrangedSubviews: [googleButton, facebookButton])
        socialStackView.axis = .horizontal
        socialStackView.spacing = 12
        socialStackView.distribution = .fillEqually

        let containerStackView = UIStackView(arrangedSubviews: [continueWithLabel, emailButton, socialStackView])
        containerStackView.axis = .vertical
        containerStackView.spacing = 12
        containerStackView.distribution = .fillEqually
        
        view.addSubview(containerStackView)
        containerStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 24))
        containerStackView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        containerBottomAnchor = containerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        containerBottomAnchor?.isActive = true
        
        view.addSubview(emailSignInView)
        emailSignInView.anchor(top: nil, leading: view.leadingAnchor, bottom: emailButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 24, bottom: 12, right: 24))
        emailSignInHeightAnchor = emailSignInView.heightAnchor.constraint(equalToConstant: 280)
        emailSignInHeightAnchor?.isActive = true
        
        view.addSubview(titleLabel)
        titleBottomAnchor = titleLabel.bottomAnchor.constraint(equalTo: emailSignInView.topAnchor, constant: -50)
        titleCenterYAnchor = titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
        titleCenterYAnchor?.isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
}
