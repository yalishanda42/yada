//
//  ServiceDependencies.swift
//  Yada
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

public protocol ServiceDependencies {
    var authenticationService: AuthenticationService { get }
}
