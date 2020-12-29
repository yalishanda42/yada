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
        
    private let store = AppStore(
        initialState: .init(),
        reducer: AppReducer.reduce,
        environment: AppServiceDependencies()
    )
    
    static func previewStore(initialState: AppState = .init()) -> AppStore {
        .init(initialState: initialState,
              reducer: AppReducer.reduce,
              environment: PreviewServiceDependencies()
        )
    }
    
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(store)
        }
    }
    
    init() {
        FirebaseApp.configure()
    }
}
