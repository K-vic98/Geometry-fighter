//
//  Geometry_fighterApp.swift
//  Geometry fighter
//
//  Created by Виктор Куделин on 19.01.2025.
//

import SwiftUI

@main
struct Geometry_fighterApp: App {
    var body: some Scene {
        WindowGroup {
            GeometryFighterGameView(
                lives: 10,
                colorTakesAwayLives: { color in
                    guard color == .red else { return false }
                    return true
                }
            )
        }
    }
}
