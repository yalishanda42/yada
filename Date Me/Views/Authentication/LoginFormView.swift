//
//  LoginView.swift
//  Date Me
//
//  Created by Alexander Ignatov on 20.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

struct LoginFormView: View {
    
    @EnvironmentObject var store: AppStore
    
    let mode: AuthenticationView.Mode
    
    @State var email = ""
    @State var password = ""
    @State var passwordRepeated = ""
            
    @State var firstSecureFieldCharsAreVisible = false
    @State var secondSecureFieldCharsAreVisible = false

    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 15) {
                    Image(systemName: "envelope").foregroundColor(.black)
                    TextField("auth.enter.email", text: $email)
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15) {
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    if firstSecureFieldCharsAreVisible {
                        TextField("auth.enter.password", text: $password)
                    } else {
                        SecureField("auth.enter.password", text: $password)
                    }
                    
                    Button(action: {
                        firstSecureFieldCharsAreVisible.toggle()
                    }) {
                        Image(systemName: "eye").foregroundColor(.black)
                    }
                }.padding(.vertical, 20)
                
                if mode == .signUp {
                    Divider()
                    
                    HStack(spacing: 15) {
                        Image(systemName: "lock")
                            .resizable()
                            .frame(width: 15, height: 18)
                            .foregroundColor(.black)
                        
                        if secondSecureFieldCharsAreVisible {
                            TextField("auth.enter.password2", text: $passwordRepeated)
                        } else {
                            SecureField("auth.enter.password2", text: $passwordRepeated)
                        }
                        
                        
                        Button(action: {
                            secondSecureFieldCharsAreVisible.toggle()
                        }) {
                            Image(systemName: "eye").foregroundColor(.black)
                        }
                    }.padding(.vertical, 20)
                }
            }.padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40 )
            .background(Color.white)
            .cornerRadius(10)
            
            Button(action: {
                switch mode {
                case .signUp:
                    store.send(.signUp(email: email, password: password, passwordRepeated: passwordRepeated))
                case .signIn:
                    store.send(.logIn(email: email, password: password))
                }
            }) {
                Text(verbatim: mode.localizedButtonText.uppercased())
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
            }.background(LinearGradient(
                gradient: .init(colors: [
                    .fromAsset(.accentRed),
                    .fromAsset(.accentPeachy),
                    .fromAsset(.accentOrange)
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )).cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom, -40)
            .shadow(radius: 15)
        }
    }
}

struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView(mode: .signIn)
        LoginFormView(mode: .signUp)
    }
}
