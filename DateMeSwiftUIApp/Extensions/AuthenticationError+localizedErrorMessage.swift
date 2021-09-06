//
//  AuthenticationError+localizedErrorMessage.swift
//  DateMeSwiftUIApp
//
//  Created by Alexander Ignatov on 6.09.21.
//  Copyright © 2021 Alexander Ignatov. All rights reserved.
//

import DateMeCore

// MARK: - Error Message

extension AuthenticationError {
    var localizedErrorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "auth.error.email_already_in_use".localized
        case .userDisabled:
            return "auth.error.disabled_account".localized
        case .invalidEmail:
            return "auth.error.invalid_email".localized
        case .networkError:
            return "auth.error.network_error".localized
        case .weakPassword:
            return "auth.error.weak_password".localized
        case .wrongPassword:
            return "auth.error.wrong_password".localized
        case .passwordsDoNotMatch:
            return "auth.error.passwords_not_matching".localized
        case .unknown:
            return "auth.error.unknown".localized
        }
    }
}
