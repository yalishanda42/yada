//
//  AppAction.swift
//  Date Me
//
//  Created by Alexander Ignatov on 26.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import Foundation

enum AppAction {
    case logIn(email: String, password: String)
    case signUp(email: String, password: String, passwordRepeated: String)
    case presentAlert(message: String)
    case dismissAlert
    case hideAuthenticationScreen
    case selectTab(AppState.Tab)
}
