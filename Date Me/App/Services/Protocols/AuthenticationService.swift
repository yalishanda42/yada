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
    case wrongPassword
    
    case passwordsDoNotMatch
    
    case unknown
    
    var localizedErrorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "auth.error.email_already_in_use".localized
        case .userDisabled:
            return "auth.error.disabled_account".localized
        case .invalidEmail:
            return "auth.error.invalid_email".localized
        case .networkError:
            return "auth.error.network_error".localized
        case .weakPassword:
            return "auth.error.weak_password".localized
        case .wrongPassword:
            return "auth.error.wrong_password".localized
        case .passwordsDoNotMatch:
            return "auth.error.passwords_not_matching".localized
        case .unknown:
            return "auth.error.unknown".localized
        }
    }
}
