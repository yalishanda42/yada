//
//  AuthenticationView.swift
//  Date Me
//
//  Created by Alexander Ignatov on 20.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

struct AuthenticationView: View {
    
    @State var mode: Mode = .signIn
            
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: .init(colors: [
                    .fromAsset(.accentOrange),
                    .fromAsset(.accentPeachy),
                    .fromAsset(.accentRed),
                ]),
                startPoint: .top,
                endPoint: .bottom
            ).edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    Image.fromAsset(.hearts)
                        .resizable()
                        .frame(width: 169, height: 169)
                        .padding(.top, 16)
                        .shadow(radius: 5)
                    
                    HStack {
                        SegmentButton(
                            associatedMode: .signIn,
                            currentIndex: $mode.buttonIndex
                        )
                        
                        SegmentButton(
                            associatedMode: .signUp,
                            currentIndex: $mode.buttonIndex
                        )
                    }.background(Color.black.opacity(0.1))
                    .clipShape(Capsule())
                    .padding(.top, 25)
                    
                    LoginFormView(mode: mode)
                    
                    if mode.buttonIndex == 0 {
                        Button(action: {
                        }) {
                            Text("auth.forgot_password")
                                .foregroundColor(.white)
                        }.padding(.top, 20)
                    }
                    
                    HStack(spacing: 15) {
                        Color.white.opacity(0.7).frame(width: 35, height: 1)
                        Text("auth.or")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        Color.white.opacity(0.7).frame(width: 35, height: 1)
                    }.padding(.top, 10)
                    
                    HStack {
                        Button(action: {
                        }) {
                            Image.fromAsset(.facebook)
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 45, height: 45)
                                .padding()
                        }.background(Color.white)
                        .clipShape(Circle())
                        
                        Button(action: {
                        }) {
                            Image.fromAsset(.apple)
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
    
    let associatedMode: AuthenticationView.Mode
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
            Text(verbatim: associatedMode.localizedSegmentButtonTitle)
                .foregroundColor(self.currentIndex == index ? .black : .white)
                .fontWeight(.bold)
                .padding(.vertical, 10)
                .frame(width: (UIScreen.main.bounds.width - 50) / 2)
        }.background(self.currentIndex == index ? Color.white : Color.clear)
        .clipShape(Capsule())
    }
}

// MARK: - Previews

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}

// MARK: - Helpers

extension AuthenticationView {
    enum Mode: Int, CaseIterable {
        case signIn = 0
        case signUp = 1
        
        var buttonIndex: Int {
            get {
                rawValue
            } set {
                self = Mode(rawValue: newValue)!
            }
        }
        
        var localizedButtonText: String {
            switch self {
            case .signIn:
                return "auth.login".localized
            case .signUp:
                return "auth.signup".localized
            }
        }
        
        var localizedSegmentButtonTitle: String {
            switch self {
            case .signIn:
                return "auth.existing".localized
            case .signUp:
                return "auth.new".localized
            }
        }
    }
}
