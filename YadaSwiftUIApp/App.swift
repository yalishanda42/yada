//
//  App.swift
//  Date Me
//
//  Created by Alexander Ignatov on 23.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI
@testable // to have access to structs' memberwise inits
import Core
import Services
import ComposableArchitecture
import Firebase

// MARK: - App

typealias AppStore = Store<AppState, AppAction>

@main
struct SwiftUIMainApp: App {
        
    private let store = AppStore(
        initialState: .init(),
        reducer: AppReducer.reduce,
        environment: AppServiceDependencies()
    )
    
    var body: some Scene {
        WindowGroup {
            RootView(store: store)
        }
    }
    
    init() {
        FirebaseApp.configure()
    }
}

// MARK: - Previews

extension SwiftUIMainApp {
    static func previewStore(initialState: AppState = .init()) -> AppStore {
        .init(initialState: initialState,
              reducer: AppReducer.reduce,
              environment: PreviewServiceDependencies()
        )
    }
}
