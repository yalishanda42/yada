//
//  AuthenticationView.swift
//  Date Me
//
//  Created by Alexander Ignatov on 20.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

struct AuthenticationView: View {
    
    @State var index = 0
        
    var body: some View {
        VStack {
            Image.hearts
                .resizable()
                .frame(width: 169, height: 169)
                .padding(.top, 16)
                .shadow(radius: 5)
            
            HStack {
                SegmentButton(
                    text: "Existing",
                    index: 0,
                    currentIndex: index
                ) {
                    self.index = 0
                }
                
                SegmentButton(
                    text: "New",
                    index: 1,
                    currentIndex: index
                ) {
                    self.index = 1
                }
            }.background(Color.black.opacity(0.1))
            .clipShape(Capsule())
            .padding(.top, 25)
            
            LoginView(mode: index == 0 ? .signIn : .signUp)
            
            if index == 0 {
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

struct SegmentButton: View {
    
    let text: String
    let index: Int
    let currentIndex: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(
                response: 0.8,
                dampingFraction: 0.5,
                blendDuration: 0.5
            )) {
                self.action()
            }
        }) {
            Text(text.localized)
                .foregroundColor(self.currentIndex == index ? .black : .white)
                .fontWeight(.bold)
                .padding(.vertical, 10)
                .frame(width: (UIScreen.main.bounds.width - 50) / 2)
        }.background(self.currentIndex == index ? Color.white : Color.clear)
        .clipShape(Capsule())
    }
}
