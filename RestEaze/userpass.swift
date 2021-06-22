//
//  userpass.swift
//  RestEaze
//
//  Created by William Jones on 5/25/21.
//

import Foundation

struct ResponseBody: Decodable {
    var message: String
    var name: String
    var email: String
    var _id: String
}

