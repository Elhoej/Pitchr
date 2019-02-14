//
//  User.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 13/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

struct User {
    let name: String
    let age: Int
    let proffesion: String
    let imageNames: [String]
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.age = 0
        self.proffesion = "Jobless"
        self.imageNames = []
    }
}
