//
//  GeometryFighterGameView.swift
//  Geometry fighter
//
//  Created by Виктор Куделин on 19.01.2025.
//

import SwiftUI
import SceneKit

struct GeometryFighterGameView: View {

    // MARK: Public properties

    @State var game: GeometryFighterGame<UIColor>
    @State var startedGame: Bool = false
    let lives: Int

    // MARK: Initializer

    init(
        lives: Int,
        colorTakesAwayLives: @escaping (UIColor) -> Bool
    ) {
        self.lives = lives
        game = .init(lives: lives, colorTakesAwayLives: colorTakesAwayLives)
    }

    // MARK: View implementation

    var body: some View {
        if !startedGame {
            Button("Start game") {
                startedGame = true
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if game.lives <= 0 {
            Button("Restart game") {
                game.lives = lives
                game.score = 0
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ZStack(alignment: .top) {
                GeometryFighterSceneView(
                    backgroundColor: .clear,
                    showsStatistics: false,
                    shapes: [.box, .capsule, .cone, .cylinder, .pyramid, .sphere, .torus, .tube],
                    shapesColors: [.red, .green, .blue, .yellow, .orange, .purple, .brown, .cyan, .orange],
                    removedGeometry: { _, color in
                        guard let color = color else { return }
                        if game.colorTakesAwayLives(color) {
                            game.lives -= 1
                        } else {
                            game.score += 1
                        }
                    }
                )

                StatisticsView(
                    units: [
                        .init(icon: "❤️", title: "\(game.lives)"),
                        .init(icon: "🏆", title: "\(game.score)"),
                    ]
                )
                .padding(.top)
            }
        }
    }
}

#Preview {
    GeometryFighterGameView(
        lives: 5,
        colorTakesAwayLives: { color in
            guard color == .red else { return false }
            return true
        }
    )
}
