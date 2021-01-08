//
//  PreviewAuthenticationService.swift
//  Date Me
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import Combine

class PreviewAuthenticationService: AuthenticationService {
    func signUpWithEmail(email: String, password: String) -> AnyPublisher<AppAction.AuthenticationInfo, AuthenticationError> {
        return Just(.init(id: "id", email: "email@example.com", fullName: "Alexander Ignatov")).mapError { _ in .unknown }.eraseToAnyPublisher()
    }
    
    func logInWithEmail(email: String, password: String) -> AnyPublisher<AppAction.AuthenticationInfo, AuthenticationError> {
        return Just(.init(id: "id", email: "email@example.com", fullName: "Alexander Ignatov")).mapError { _ in .unknown }.eraseToAnyPublisher()
    }
}
