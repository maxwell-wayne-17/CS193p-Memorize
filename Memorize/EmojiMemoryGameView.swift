//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Maxwell Wayne on 8/26/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
        }
        .padding()
        .foregroundColor(.red)
    }
    
    
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90) )
                    .padding(DrawingConstants.circlePadding)
                    .opacity(DrawingConstants.circleOpacity)
                Text(card.content)
                    .rotationEffect( Angle.degrees( card.isMatched ? 360 : 0 ) )
                    .animation( Animation.linear( duration: 1).repeatForever(autoreverses: false), value: card.isMatched )
                    .font( Font.system(size: DrawingConstants.fontSize) )
                    .scaleEffect( scale( thatFits: geometry.size ) )
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system( size: min(size.width, size.height) * DrawingConstants.fontScale )
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
        static let circlePadding: CGFloat = 5
        static let circleOpacity = 0.5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
//        EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.light)
    }
}
