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
    
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(store)
        }
    }
    
    init() {
        FirebaseApp.configure()
    }
    
    static var previewStore: AppStore {
        .init(initialState: .init(),
              reducer: AppReducer.reduce,
              environment: PreviewServiceDependencies()
        )
    }
}
