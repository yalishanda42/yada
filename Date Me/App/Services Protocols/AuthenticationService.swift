//
//  AuthenticationService.swift
//  Date Me
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import Combine

protocol AuthenticationService {    
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
}
