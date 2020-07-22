//
//  FlowController.swift
//  Date Me
//
//  Created by Alexander Ignatov on 21.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

class FlowController {
    
    lazy var rootView: RootView = RootView(viewModel: rootViewModel)
    lazy var rootViewModel = RootViewModel(authenticationService: services.authenticationService)
    
    let window: UIWindow
    let services: ServiceDepdendencies
    
    init(in window: UIWindow, services: ServiceDepdendencies) {
        self.window = window
        self.services = services
        
        window.rootViewController = UIHostingController(rootView: rootView)
        window.makeKeyAndVisible()
    }
}
