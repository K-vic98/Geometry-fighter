//
//  GeometryFighterGame.swift
//  Geometry fighter
//
//  Created by Виктор Куделин on 03.02.2025.
//

import UIKit

struct GeometryFighterGame<Color> {
    var lives: Int
    var score: Int = 0
    let colorTakesAwayLives: (Color) -> Bool
}
