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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    private static let services = AppServiceDependencies()
    private static let rootViewModel = RootViewModel(authenticationService: services.authenticationService)
    
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: DateMeApp.rootViewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
