//
//  AccountView.swift
//  Date Me
//
//  Created by Alexander Ignatov on 20.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        VStack {
            switch store.state.user {
            case .guest(_):
                Spacer()
                Button("account.authenticate_button") {
                    store.send(.showAuthentication)
                }.accentColor(.fromAsset(.accentPeachy))
            case .authenticated(let userState):
                loggedInHeader(userState)
            }
            Spacer()
        }
    }
    
    private func loggedInHeader(_ state: AppState.AuthenticatedUser) -> some View {
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
                    store.send(.hideSettings)
                },
                isActive: .constant(store.state.settingsAreShown)
            ) {
                Button {
                    store.send(.showSettings)
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

// MARK: - Previews

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        // initial state (guest user)
        AccountView().environmentObject(DateMeApp.previewStore())
            .previewDisplayName("Guest - Light")
            .preferredColorScheme(.light)
        
        AccountView().environmentObject(DateMeApp.previewStore())
            .previewDisplayName("Guest - Dark")
            .preferredColorScheme(.dark)
        
        // authenticated user state
        AccountView().environmentObject(DateMeApp.previewStore(
            initialState: .init(
                user: .authenticated(.init(
                    email: "email@example.com",
                    fullName: "Alexander Ignatov"
                ))
            )
        )).previewDisplayName("Logged - Light")
        .preferredColorScheme(.light)
        
        AccountView().environmentObject(DateMeApp.previewStore(
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
