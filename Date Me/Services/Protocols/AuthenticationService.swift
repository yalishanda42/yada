//
//  AuthenticationService.swift
//  Date Me
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import Combine

protocol AuthenticationService {
    var isAuthenticated: AnyPublisher<Bool, Never> { get }
    
    func signUpWithEmail(email: String, password: String) -> AnyPublisher<Void, AuthenticationError>
    
    func logInWithEmail(email: String, password: String) -> AnyPublisher<Void, AuthenticationError>
}

enum AuthenticationError: Error {
    case emailAlreadyInUse
    case userDisabled
    case invalidEmail
    case networkError
    case weakPassword
    
    case unknown
    
    var localizedErrorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account".localized
        case .userDisabled:
            return "Your account has been disabled. Please contact support.".localized
        case .invalidEmail:
            return "Please enter a valid email".localized
        case .networkError:
            return "Network error. Please try again.".localized
        case .weakPassword:
            return "Your password is too weak".localized
        case .unknown:
            return "Unknown error occurred".localized
        }
    }
}
