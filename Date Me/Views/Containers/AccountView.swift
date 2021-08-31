//
//  AccountView.swift
//  Date Me
//
//  Created by Alexander Ignatov on 20.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct AccountView: View {
    
    let store: AppStore
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                switch viewStore.user {
                case .guest(_):
                    Spacer()
                    Button("account.authenticate_button") {
                        viewStore.send(.showAuthentication)
                    }.accentColor(.fromAsset(.accentPeachy))
                case .authenticated(let userState):
                    loggedInHeader(userState)
                }
                Spacer()
            }
        }
    }
    
    private func loggedInHeader(_ state: AppState.AuthenticatedUser) -> some View {
        WithViewStore(store) { viewStore in
            HStack {
                Image(systemName: "person.badge.plus")
                    .renderingMode(.original)
                    .font(.system(
                        size: 69,
                        weight: .regular
                    ))
                    .padding()
                    .background(Color(
                        white: 0.9,
                        opacity: 0.69
                    ))
                    .clipShape(Circle())
                
                Text(verbatim: state.fullName)
                    .padding(.leading, 42)
                    .font(.title)
                
                Spacer()
                
                NavigationLink(
                    destination: SettingsView().withCustomBackButton {
                        viewStore.send(.hideSettings)
                    },
                    isActive: .constant(viewStore.settingsAreShown)
                ) {
                    Button {
                        viewStore.send(.showSettings)
                    } label: {
                        Image(systemName: "gear")
                            .font(.system(
                                size: 36,
                                weight: .regular
                            ))
                            .padding()
                    }.accentColor(.primary)
                }
            }.background(Color(.secondarySystemBackground))
        }
    }
}

// MARK: - Previews

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        // initial state (guest user)
        AccountView(store: DateMeApp.previewStore())
            .previewDisplayName("Guest - Light")
            .preferredColorScheme(.light)
        
        AccountView(store: DateMeApp.previewStore())
            .previewDisplayName("Guest - Dark")
            .preferredColorScheme(.dark)
        
        // authenticated user state
        AccountView(store: DateMeApp.previewStore(
            initialState: .init(
                user: .authenticated(.init(
                    email: "email@example.com",
                    fullName: "Alexander Ignatov"
                ))
            )
        )).previewDisplayName("Logged - Light")
        .preferredColorScheme(.light)
        
        AccountView(store: DateMeApp.previewStore(
            initialState: .init(
                user: .authenticated(.init(
                    email: "email@example.com",
                    fullName: "Alexander Ignatov"
                ))
            )
        )).previewDisplayName("Logged - Dark")
        .preferredColorScheme(.dark)
    }
}
