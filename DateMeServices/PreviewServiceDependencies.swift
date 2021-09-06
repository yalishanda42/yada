//
//  PreviewServiceDependencies.swift
//  Date Me
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import DateMeCore

public class PreviewServiceDependencies: ServiceDependencies {
    public lazy var authenticationService: AuthenticationService = PreviewAuthenticationService()
    
    public init() {}
}
