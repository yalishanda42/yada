//
//  AuthenticationService.swift
//  Yada
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import ComposableArchitecture

public protocol AuthenticationService {
    func signUpWithEmail(email: String, password: String) -> Effect<AppAction.AuthenticationInfo, AuthenticationError>
    
    func logInWithEmail(email: String, password: String) -> Effect<AppAction.AuthenticationInfo, AuthenticationError>
}

public enum AuthenticationError: Error {
    case emailAlreadyInUse
    case userDisabled
    case invalidEmail
    case networkError
    case weakPassword
    case wrongPassword
    
    case passwordsDoNotMatch
    
    case unknown
}
