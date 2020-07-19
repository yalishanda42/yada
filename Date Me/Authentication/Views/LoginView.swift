//
//  LoginView.swift
//  Date Me
//
//  Created by Alexander Ignatov on 20.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    let mode: Mode
    
    @State var email = ""
    @State var pass = ""
    @State var pass2 = ""
    
    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 15) {
                    Image(systemName: "envelope").foregroundColor(.black)
                    TextField("Enter e-mail address".localized, text: $email)
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15) {
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    SecureField("Enter password".localized, text: $pass)
                    
                    Button(action: {}) {
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
                        
                        SecureField("Repeat password".localized, text: $pass2)
                        
                        Button(action: {}) {
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
            }) {
                Text(mode.buttonText.localized.uppercased())
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
            }.background(LinearGradient(
                gradient: .init(colors: [
                    .accentRed,
                    .accentPeachy,
                    .accentOrange
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

extension LoginView {
    enum Mode {
        case signIn
        case signUp
        
        var buttonText: String {
            switch self {
            case .signIn:
                return "Login"
            case .signUp:
                return "Sign up"
            }
        }
    }
}
