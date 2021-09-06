//
//  RootView.swift
//  Date Me
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI
import DateMeCore
import ComposableArchitecture

struct RootView: View {
    
    let store: AppStore
    
    var body: some View {
        WithViewStore(store) { viewStore in
            TabBar(store: store)
                .fullScreenCover(isPresented: viewStore.binding(
                    get: { $0.authScreenIsPresented },
                    send: { $0
                        ? .showAuthentication
                        : .hideAuthentication
                    }
                )) {
                    AuthenticationView(
                        cancelAction: {
                            viewStore.send(.hideAuthentication)
                        },
                        signUpAction: {
                            viewStore.send(.signUp(
                                email: $0,
                                password: $1,
                                passwordRepeated: $2
                            ))
                        },
                        signInAction: {
                            viewStore.send(.logIn(
                                email: $0, password: $1
                            ))
                        }
                    ).alert(isPresented: .constant(viewStore.alertIsPresented)) {
                        Alert(
                            title: Text("alert.error"),
                            message: Text(viewStore.alertTextMessage),
                            dismissButton: .default(Text("alert.ok"),
                                action: {
                                    viewStore.send(.hideAlert)
                                }
                            )
                        )
                    }
                }
        }
    }
}

// MARK: - Previews

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: DateMeApp.previewStore())
            .previewDisplayName("Light")
            .preferredColorScheme(.light)
        
        RootView(store: DateMeApp.previewStore())
            .previewDisplayName("Dark")
            .preferredColorScheme(.dark)
    }
}
