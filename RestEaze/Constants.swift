//
//  Constants.swift
//  RestEaze
//
//  Created by William Jones on 6/24/21.
//

import Foundation

struct Constants {
    
    struct Storyboard {
        static let homeViewController = "HomeVC"
    }
    struct Strings {
        static let successMessage = "Login Successful!"
        static let nameEmpty = "name cannot be empty"
        static let passwordEmpty = "password cannot be empty"
        static let nameLength = "Name must be at least 5 characters long"
        static let emailEmpty = "Email cannot be empty"
    }
    struct Errors {
        static let nameError = "\"name\" is not allowed to be empty"
        static let passwordError = "\"password\" is not allowed to be empty"
        static let emailError = "\"email\" is not allowed to be empty"
        static let nameShort = "\"name\" length must be at least 5 characters long"
    }
}
