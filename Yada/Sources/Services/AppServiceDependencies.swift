//
//  AppServiceDependencies.swift
//  Yada
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import Core

public class AppServiceDependencies: ServiceDependencies {
    public lazy var authenticationService: AuthenticationService = FirebaseAuthenticationService()
    
    public init() {}
}
