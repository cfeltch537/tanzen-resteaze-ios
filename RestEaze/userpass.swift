//
//  userpass.swift
//  RestEaze
//
//  Created by William Jones on 5/25/21.
//

import Foundation

struct UserPass: Codable{
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
}

struct ResponseBody: Decodable {
    var message: String
    var name: String
    var email: String
    var userId: String
}

