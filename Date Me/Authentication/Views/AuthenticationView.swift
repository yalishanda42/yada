//
//  AuthenticationView.swift
//  Date Me
//
//  Created by Alexander Ignatov on 20.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

struct AuthenticationView: View {
    
    @ObservedObject var viewModel: AuthenticationViewModel
        
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: .init(colors: [
                    .accentOrange,
                    .accentPeachy,
                    .accentRed
                ]),
                startPoint: .top,
                endPoint: .bottom
            ).edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    Image.hearts
                        .resizable()
                        .frame(width: 169, height: 169)
                        .padding(.top, 16)
                        .shadow(radius: 5)
                    
                    HStack {
                        SegmentButton(
                            associatedMode: .signIn,
                            currentIndex: $viewModel.mode.buttonIndex
                        )
                        
                        SegmentButton(
                            associatedMode: .signUp,
                            currentIndex: $viewModel.mode.buttonIndex
                        )
                    }.background(Color.black.opacity(0.1))
                    .clipShape(Capsule())
                    .padding(.top, 25)
                    
                    LoginFormView(viewModel: viewModel.loginFormViewModel)
                    
                    if viewModel.mode.buttonIndex == 0 {
                        Button(action: {
                        }) {
                            Text("Forgot password?".localized).foregroundColor(.white)
                        }.padding(.top, 20)
                    }
                    
                    HStack(spacing: 15) {
                        Color.white.opacity(0.7).frame(width: 35, height: 1)
                        Text("Or".localized)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        Color.white.opacity(0.7).frame(width: 35, height: 1)
                    }.padding(.top, 10)
                    
                    HStack {
                        Button(action: {
                        }) {
                            Image.facebook
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 45, height: 45)
                                .padding()
                        }.background(Color.white)
                        .clipShape(Circle())
                        
                        Button(action: {
                        }) {
                            Image.apple
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 45, height: 45)
                                .padding()
                        }.background(Color.white)
                        .clipShape(Circle())
                        .padding(.leading, 25)
                    }.padding(.top, 10)
                    
                }.padding()
            }
        }
    }
}

struct SegmentButton: View {
    
    let associatedMode: AuthenticationViewModel.Mode
    @Binding var currentIndex: Int
    
    var index: Int {
        associatedMode.buttonIndex
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                self.currentIndex = self.index
            }
        }) {
            Text(associatedMode.segmentButtonTitle)
                .foregroundColor(self.currentIndex == index ? .black : .white)
                .fontWeight(.bold)
                .padding(.vertical, 10)
                .frame(width: (UIScreen.main.bounds.width - 50) / 2)
        }.background(self.currentIndex == index ? Color.white : Color.clear)
        .clipShape(Capsule())
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(viewModel: AuthenticationViewModel())
    }
}
