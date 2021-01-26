//
//  RootView.swift
//  Date Me
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        currentView
            .alert(isPresented: .constant(store.state.alertIsPresented)) {
                Alert(
                    title: Text("alert.error"),
                    message: Text(store.state.alertTextMessage),
                    dismissButton: .default(Text("alert.ok"),
                        action: {
                            store.send(.hideAlert)
                        }
                    )
                )
            }
    }
    
    var currentView: some View {
        if store.state.authScreenIsPresented {
            return AuthenticationView {
                store.send(.hideAuthentication)
            }.eraseToAnyView()
        } else {
            return TabBar().eraseToAnyView()
        }
    }
}

// MARK: - Previews

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(DateMeApp.previewStore())
            .previewDisplayName("Light")
            .preferredColorScheme(.light)
        
        RootView()
            .environmentObject(DateMeApp.previewStore())
            .previewDisplayName("Dark")
            .preferredColorScheme(.dark)
    }
}
