//
//  LoginView.swift
//  Date Me
//
//  Created by Alexander Ignatov on 20.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

struct LoginFormView: View {
        
    @ObservedObject var viewModel: LoginFormViewModel
    
    @State var firstSecureFieldCharsAreVisible = false
    @State var secondSecureFieldCharsAreVisible = false

    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 15) {
                    Image(systemName: "envelope").foregroundColor(.black)
                    TextField("Enter e-mail address".localized, text: $viewModel.emailText)
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15) {
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    if firstSecureFieldCharsAreVisible {
                        TextField("Enter password".localized, text: $viewModel.passwordText)
                    } else {
                        SecureField("Enter password".localized, text: $viewModel.passwordText)
                    }
                    
                    Button(action: {
                        firstSecureFieldCharsAreVisible.toggle()
                    }) {
                        Image(systemName: "eye").foregroundColor(.black)
                    }
                }.padding(.vertical, 20)
                
                if viewModel.mode == .signUp {
                    Divider()
                    
                    HStack(spacing: 15) {
                        Image(systemName: "lock")
                            .resizable()
                            .frame(width: 15, height: 18)
                            .foregroundColor(.black)
                        
                        if secondSecureFieldCharsAreVisible {
                            TextField("Repeat password".localized, text: $viewModel.passwordRepeatedText)
                        } else {
                            SecureField("Repeat password".localized, text: $viewModel.passwordRepeatedText)
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
                self.viewModel.buttonTap.send()
            }) {
                Text(viewModel.mode.buttonText.uppercased())
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

struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView(viewModel: LoginFormViewModel(mode: .signIn))
        LoginFormView(viewModel: LoginFormViewModel(mode: .signUp))
    }
}
