//
//  App.swift
//  Date Me
//
//  Created by Alexander Ignatov on 23.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI
import Firebase

@main
struct DateMeApp: App {
        
    private static let services = AppServiceDependencies()
    private static let rootViewModel = RootViewModel(services: services)
    
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: DateMeApp.rootViewModel)
        }
    }
    
    init() {
        FirebaseApp.configure()
    }
}
