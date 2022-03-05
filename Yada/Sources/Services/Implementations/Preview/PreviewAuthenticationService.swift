//
//  PreviewAuthenticationService.swift
//  Yada
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

@testable // to have access to structs' memberwise inits
import Core
import ComposableArchitecture

class PreviewAuthenticationService: AuthenticationService {
    public func signUpWithEmail(email: String, password: String) -> Effect<AppAction.AuthenticationInfo, AuthenticationError> {
        return .init(value: AppAction.AuthenticationInfo(id: "id", email: "email@example.com", fullName: "Alexander Ignatov"))
    }
    
    public func logInWithEmail(email: String, password: String) -> Effect<AppAction.AuthenticationInfo, AuthenticationError> {
        return .init(value: .init(id: "id", email: "email@example.com", fullName: "Alexander Ignatov"))
    }
}
