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
                Text(verbatim: "Alexander Ignatov")
                    .padding(.leading, 42)
                    .font(.title)
                Spacer()
                
                NavigationLink(
                    destination: SettingsView()
                        .withCustomBackButton {
                            store.send(.popBackSettings)
                    },
                    isActive: .constant(store.state.settingsAreShown)) {
                    Button {
                        store.send(.tapSettings)
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
            
            Spacer()
        }
    }
}

// MARK: - Previews

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView().environmentObject(DateMeApp.previewStore())
    }
}
