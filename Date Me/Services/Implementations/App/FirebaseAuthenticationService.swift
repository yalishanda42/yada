//
//  FirebaseAuthenticationService.swift
//  Date Me
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import Firebase
import Combine

class FirebaseAuthenticationService: AuthenticationService {
    func signUpWithEmail(email: String, password: String) -> AnyPublisher<Void, AuthenticationError> {
        return Future { event in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard result != nil else {
                    event(.failure(.init(error)))
                    return
                }
                event(.success(()))
            }
        }.eraseToAnyPublisher()
    }
    
    func logInWithEmail(email: String, password: String) -> AnyPublisher<Void, AuthenticationError> {
        return Future { event in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                guard result != nil else {
                    event(.failure(.init(error)))
                    return
                }
                event(.success(()))
            }
        }.eraseToAnyPublisher()
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
