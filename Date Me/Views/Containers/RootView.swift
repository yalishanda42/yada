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
        TabBar()
            .fullScreenCover(isPresented: store.authScreenIsPresentedBinding) {
                AuthenticationView(
                    cancelAction: {
                        store.send(.hideAuthentication)
                    },
                    signUpAction: {
                        store.send(.signUp(
                            email: $0,
                            password: $1,
                            passwordRepeated: $2
                        ))
                    },
                    signInAction: {
                        store.send(.logIn(
                            email: $0, password: $1
                        ))
                    }
                ).alert(isPresented: .constant(store.state.alertIsPresented)) {
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

// MARK: - Helpers

extension AppStore {
    var authScreenIsPresentedBinding: Binding<Bool> {
        .init {
            self.state.authScreenIsPresented
        } set: {
            self.send(
                $0 ? .showAuthentication : .hideAuthentication
            )
        }
    }
}
