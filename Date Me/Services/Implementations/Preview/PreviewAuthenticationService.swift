//
//  PreviewAuthenticationService.swift
//  Date Me
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import Combine
import ComposableArchitecture

class PreviewAuthenticationService: AuthenticationService {
    func signUpWithEmail(email: String, password: String) -> Effect<AppAction.AuthenticationInfo, AuthenticationError> {
        return .init(value: .init(id: "id", email: "email@example.com", fullName: "Alexander Ignatov"))
    }
    
    func logInWithEmail(email: String, password: String) -> Effect<AppAction.AuthenticationInfo, AuthenticationError> {
        return .init(value: .init(id: "id", email: "email@example.com", fullName: "Alexander Ignatov"))
    }
}
