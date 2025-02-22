//
//  GameViewController+Representable.swift
//  Geometry fighter
//
//  Created by Виктор Куделин on 19.01.2025.
//

import SwiftUI
import SceneKit

struct GeometryFighterSceneView: UIViewControllerRepresentable {

    // MARK: Public properties

    let backgroundColor: UIColor
    let showsStatistics: Bool
    let shapes: Set<Shape>
    let shapesColors: Set<UIColor>
    let removedGeometry: (SCNGeometry?, UIColor?) -> Void

    // MARK: UIViewControllerRepresentable implementation

    func makeUIViewController(context: Context) -> GeometryFighterSceneViewController {
        GeometryFighterSceneViewController(
            backgroundColor: backgroundColor,
            showsStatistics: showsStatistics,
            shapes: shapes,
            shapesColors: shapesColors,
            removedGeometry: removedGeometry
        )
    }

    func updateUIViewController(_ uiViewController: GeometryFighterSceneViewController, context: Context)  {}
}

#Preview {
    GeometryFighterSceneView(
        backgroundColor: .blue,
        showsStatistics: true,
        shapes: [.box, .capsule, .cone, .cylinder],
        shapesColors: [.red, .yellow, .green, .white],
        removedGeometry: { _, _ in }
    )
}
