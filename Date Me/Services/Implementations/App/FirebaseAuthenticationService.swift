//
//  FirebaseAuthenticationService.swift
//  Date Me
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import Firebase
import Combine
import ComposableArchitecture

class FirebaseAuthenticationService: AuthenticationService {
    func signUpWithEmail(email: String, password: String) -> Effect<AppAction.AuthenticationInfo, AuthenticationError> {
        return Future { event in
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }
                guard let result = result else {
                    event(.failure(.init(error)))
                    return
                }
                let info = self.retrieveAuthInfoFromFirebaseUserResult(result)
                event(.success(info))
            }
        }.eraseToEffect()
    }
    
    func logInWithEmail(email: String, password: String) -> Effect<AppAction.AuthenticationInfo, AuthenticationError> {
        return Future { event in
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }
                guard let result = result else {
                    event(.failure(.init(error)))
                    return
                }
                let info = self.retrieveAuthInfoFromFirebaseUserResult(result)
                event(.success(info))
            }
        }.eraseToEffect()
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
