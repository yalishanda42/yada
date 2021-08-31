//
//  CardsDeckView.swift
//  Date Me
//
//  Created by Alexander Ignatov on 6.03.21.
//  Copyright © 2021 Alexander Ignatov. All rights reserved.
//

import SwiftUI

protocol CardDataProtocol {
    var image: String { get }
    var title: String { get }
}

struct CardsDeckView: View {
    @State private var cardData: [CardDataProtocol] = []
    @State private var offsets: [CGFloat] = []
    @State private var scrolled = 0
    @State private var index = 0
    @State private var index1 = 0
    
    init(_ cardsData: [CardDataProtocol]) {
        self.cardData = cardsData
        self.offsets = Array(repeating: 0.0, count: cardsData.count)
    }
    
    var body: some View {
        ZStack {
            ForEach((0..<cardData.count).reversed(), id: \.self) { i in
                CardView(imageName: cardData[cardsCount - i].image, title: cardData[cardsCount - i].title)
                    .frame(width: calculateWidth(), height: (UIScreen.main.bounds.height / 1.8) - CGFloat(i - scrolled) * 50)
                    .offset(x: i - scrolled <= 2 ? CGFloat(i - 1 - scrolled) * 30 : 60)
                    .offset(x: offsets[i])
                    .gesture(DragGesture()
                        .onChanged({ (value) in
                            withAnimation{
                                // disable drag for the last card
                                if value.translation.width < 0 && i != cardData.indices.last {
                                    offsets[i] = value.translation.width
                                } else{
                                    // restoring cards...
                                    if i > 0{
                                        offsets[i] = -(calculateWidth() + 60) + value.translation.width
                                    }
                                }
                            }
                        }).onEnded({ (value) in
                            withAnimation{
                                if value.translation.width < 0{
                                    if -value.translation.width > 180 && i != cardData.indices.last {
                                        
                                        // moving view away...
                                        
                                        offsets[i] = -(calculateWidth() + 60)
                                        scrolled += 1
                                    }
                                    else{
                                        
                                        offsets[i] = 0
                                    }
                                }
                                else{
                                    
                                    // restoring card...
                                    
                                    if i > 0{
                                        if value.translation.width > 180{
                                            offsets[i - 1] = 0
                                            scrolled -= 1
                                        }
                                        else{
                                            offsets[i - 1] = -(calculateWidth() + 60)
                                        }
                                    }
                                }
                            }
                        })
                )
            }
        }
        // max height...
        .frame(height: UIScreen.main.bounds.height / 1.8)
        .padding(.horizontal,25)
        .padding(.top,25)
        
    }
    
    private var cardsCount: Int {
        cardData.count
    }
    
    private func calculateWidth() -> CGFloat{
              
              // horizontal padding 50
              
              let screen = UIScreen.main.bounds.width - 50
              
              // going to show first three cards
              // all other will be hidden....
              
              // scnd and third will be moved x axis with 30 value..
              
              let width = screen - (2 * 30)
              
              return width
          }
}

// MARK: - Previews

struct PreviewCardData: CardDataProtocol {
    var image: String
    var title: String
}

struct CardsDeckView_Previews: PreviewProvider {
    
    private static var deck: [PreviewCardData] = [
        .init(image: "card1", title: "Card 1"),
        .init(image: "card2", title: "Card 2"),
        .init(image: "card3", title: "Card 3"),
        .init(image: "card4", title: "Card 4"),
    ]
    
    static var previews: some View {
        CardsDeckView(deck)
    }
}
