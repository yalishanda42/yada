//
//  MockAuthenticationService.swift
//  DateMeTests
//
//  Created by Alexander Ignatov on 5.01.21.
//  Copyright © 2021 Alexander Ignatov. All rights reserved.
//

import Combine
import ComposableArchitecture
@testable import Date_Me

class MockAuthenticationService: AuthenticationService, MockService {
    
    var mockedSignUpWithEmail: Effect<AppAction.AuthenticationInfo, AuthenticationError>!
    var mockedLoginWithEmail: Effect<AppAction.AuthenticationInfo, AuthenticationError>!
    
    func signUpWithEmail(email: String, password: String) -> Effect<AppAction.AuthenticationInfo, AuthenticationError> {
        mockedSignUpWithEmail
    }
    
    func logInWithEmail(email: String, password: String) -> Effect<AppAction.AuthenticationInfo, AuthenticationError> {
        mockedLoginWithEmail
    }
}
