//
//  CardView.swift
//  Date Me
//
//  Created by Alexander Ignatov on 7.03.21.
//  Copyright © 2021 Alexander Ignatov. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    let imageName: String
    let title: String
    let action: () -> Void = {}
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)){
            
            Image(imageName)
                .resizable()
                .clipShape(Rectangle())
                .cornerRadius(15)
            
            VStack(alignment: .leading, spacing: 18){
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    
                Button(action: action) {
                    Text("Read Later")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 25)
                        .background(Color.gray)
                        .clipShape(Capsule())
                }
            }
            .padding(.leading, 20)
            .padding(.bottom, 20)
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(imageName: "card1", title: "Card 1").frame(width: 300, height: 16/10 * 300)
        CardView(imageName: "card2", title: "Card 2").frame(width: 300, height: 16/10 * 300)
        CardView(imageName: "card3", title: "Card 3").frame(width: 300, height: 16/10 * 300)
        CardView(imageName: "card4", title: "Card 4").frame(width: 300, height: 16/10 * 300)
    }
}
