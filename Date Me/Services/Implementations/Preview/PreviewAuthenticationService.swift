//
//  PreviewAuthenticationService.swift
//  Date Me
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import Combine

class PreviewAuthenticationService: AuthenticationService {
    let isAuthenticated: AnyPublisher<Bool, Never>
    private let isAuthenticatedSubject = CurrentValueSubject<Bool, Never>(false)
    
    init() {
        self.isAuthenticated = isAuthenticatedSubject.eraseToAnyPublisher()
    }
    
    func signUpWithEmail(email: String, password: String) -> AnyPublisher<Void, AuthenticationError> {
        return Just<Void>(()).mapError { _ in .unknown }.eraseToAnyPublisher()
    }
    
    func logInWithEmail(email: String, password: String) -> AnyPublisher<Void, AuthenticationError> {
        isAuthenticatedSubject.send(true)
        return Just<Void>(()).mapError { _ in .unknown }.eraseToAnyPublisher()
    }
    
}
