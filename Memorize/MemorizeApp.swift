//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Maxwell Wayne on 8/26/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
