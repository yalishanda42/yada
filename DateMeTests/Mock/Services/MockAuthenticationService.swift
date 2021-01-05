//
//  MockAuthenticationService.swift
//  DateMeTests
//
//  Created by Alexander Ignatov on 5.01.21.
//  Copyright © 2021 Alexander Ignatov. All rights reserved.
//

import Combine
@testable import Date_Me

class MockAuthenticationService: AuthenticationService, MockService {
    
    var mockedSignUpWithEmail: AnyPublisher<Void, AuthenticationError>!
    var mockedLoginWithEmail: AnyPublisher<Void, AuthenticationError>!
    
    func signUpWithEmail(email: String, password: String) -> AnyPublisher<Void, AuthenticationError> {
        mockedSignUpWithEmail
    }
    
    func logInWithEmail(email: String, password: String) -> AnyPublisher<Void, AuthenticationError> {
        mockedLoginWithEmail
    }
}
