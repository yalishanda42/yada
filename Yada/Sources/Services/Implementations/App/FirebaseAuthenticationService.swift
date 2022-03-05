//
//  FirebaseAuthenticationService.swift
//  Yada
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import Firebase
@testable // to have access to structs' memberwise inits
import Core
import ComposableArchitecture

class FirebaseAuthenticationService: AuthenticationService {
    func signUpWithEmail(email: String, password: String) -> Effect<AppAction.AuthenticationInfo, AuthenticationError> {
        Effect.future { event in
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }
                guard let result = result else {
                    event(.failure(.init(error)))
                    return
                }
                let info = self.retrieveAuthInfoFromFirebaseUserResult(result)
                event(.success(info))
            }
        }
    }
    
    func logInWithEmail(email: String, password: String) -> Effect<AppAction.AuthenticationInfo, AuthenticationError> {
        Effect.future { event in
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }
                guard let result = result else {
                    event(.failure(.init(error)))
                    return
                }
                let info = self.retrieveAuthInfoFromFirebaseUserResult(result)
                event(.success(info))
            }
        }
    }
    
    private func retrieveAuthInfoFromFirebaseUserResult(_ result: AuthDataResult) -> AppAction.AuthenticationInfo {
        let user = result.user
        let id = user.uid
        let email = user.email ?? "" // TODO
        let names = user.displayName ?? "" // TODO
        return .init(id: id, email: email, fullName: names)
    }
}

extension Error {
    func asAuthenticationError() -> AuthenticationError {
        guard let firError = AuthErrorCode(rawValue: (self as NSError).code) else {
            return .unknown
        }
        
        switch firError {
        case .emailAlreadyInUse: return .emailAlreadyInUse
        case .userDisabled: return .userDisabled
        case .invalidEmail,
             .invalidSender,
             .invalidRecipientEmail:
            return .invalidEmail
        case .networkError: return .networkError
        case .weakPassword: return .weakPassword
        case .wrongPassword: return .wrongPassword
        default:
            return .unknown
        }
    }
}

extension AuthenticationError {
    init(_ error: Error?) {
        if let error = error {
            self = error.asAuthenticationError()
        } else {
            self = .unknown
        }
    }
}
