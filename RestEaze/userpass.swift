//
//  userpass.swift
//  RestEaze
//
//  Created by William Jones on 5/25/21.
//

import Foundation

struct UserPass: Codable{
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
}

struct ResponseBody: Decodable {
    var message: String
    var name: String
    var email: String
    var userId: String
}

