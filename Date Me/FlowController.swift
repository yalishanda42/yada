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
    lazy var rootViewModel = RootViewModel()
    
    let window: UIWindow
    
    init(in window: UIWindow) {
        self.window = window
        
        window.rootViewController = UIHostingController(rootView: rootView)
        window.makeKeyAndVisible()
    }
}
