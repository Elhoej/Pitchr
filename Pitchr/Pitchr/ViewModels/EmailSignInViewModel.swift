//
//  RegistrationViewModel.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 13/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class EmailSignInViewModel {
    var isInLoginState: Bool { didSet { checkLoginState() }}
    var name: String? { didSet { checkIfFormIsValid() }}
    var email: String? { didSet { checkIfFormIsValid() }}
    var password: String? { didSet { checkIfFormIsValid() }}

    init(isInLoginState: Bool) {
        self.isInLoginState = isInLoginState
    }

    var isFormValidObserver: ((Bool) -> ())?
    var loginStateObserver: ((Bool) -> ())?
    
    fileprivate func checkIfFormIsValid() {
        let isFormValid = name?.isEmpty == false && email?.count ?? 0 > 4 && email?.contains("@") ?? false && password?.count ?? 0 > 5
        isFormValidObserver?(isFormValid)
    }
    
    func changeLoginState() {
        isInLoginState = isInLoginState ? false : true
    }
    
    fileprivate func checkLoginState() {
        loginStateObserver?(isInLoginState)
    }
}
