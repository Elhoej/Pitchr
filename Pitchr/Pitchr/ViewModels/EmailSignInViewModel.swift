//
//  RegistrationViewModel.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 13/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit
import Firebase

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
        if isInLoginState {
            let isFormValid = email?.count ?? 0 > 4 && email?.contains("@") ?? false && password?.count ?? 0 > 5
            isFormValidObserver?(isFormValid)
        } else {
            let isFormValid = name?.isEmpty == false && email?.count ?? 0 > 4 && email?.contains("@") ?? false && password?.count ?? 0 > 5
            isFormValidObserver?(isFormValid)
        }
    }
    
    func changeLoginState() {
        isInLoginState = isInLoginState ? false : true
        checkIfFormIsValid()
    }
    
    fileprivate func checkLoginState() {
        loginStateObserver?(isInLoginState)
    }
    
    func performRegistration(completion: @escaping (Error?) -> ()) {
        guard let email = email, let password = password else { return }
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                NSLog("An error occured when creating a new user: \(error)")
                completion(error)
                return
            }
            
            self.saveUserToFirestore(uid: result?.user.uid ?? "", completion: completion)
        }
    }
    
    func saveUserToFirestore(uid: String = Auth.auth().currentUser?.uid ?? "", completion: @escaping (Error?) -> ()) {
        let data = ["name": name ?? "", "uid": uid, "email": email ?? ""]
        Firestore.firestore().collection("users").document(uid).setData(data) { (error) in
            
            if let error = error {
                NSLog("An error occured when saving a user to Firestore: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }
    }
}
