//
//  GameViewController.swift
//  Geometry fighter
//
//  Created by Виктор Куделин on 19.01.2025.
//

import UIKit
import SceneKit

final class GeometryFighterSceneViewController: UIViewController {

    // MARK: Private properties

    private let scene: SCNScene = SCNScene()
    private let sceneView: SCNView = SCNView()
    private let backgroundColor: UIColor
    private let showsStatistics: Bool
    private let shapes: Set<Shape>
    private let shapesColors: Set<UIColor>
    private let removedGeometry: (SCNGeometry?, UIColor?) -> Void

    private var geometrySpawnTime: TimeInterval = 0

    private var randomPhysicsBodyWithForce: SCNPhysicsBody {
        let physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        let randomX: Float = .random(in: -2...2)
        let randomY: Float = .random(in: 10...18)
        physicsBody.applyForce(
            SCNVector3(x: randomX, y: randomY, z: 0),
            at: SCNVector3(x: 0.05, y: 0.05, z: 0.05),
            asImpulse: true
        )
        return physicsBody
    }

    // MARK: Initializer

    init(
        backgroundColor: UIColor,
        showsStatistics: Bool,
        shapes: Set<Shape>,
        shapesColors: Set<UIColor>,
        removedGeometry: @escaping (SCNGeometry?, UIColor?) -> Void
    ) {
        self.backgroundColor = backgroundColor
        self.showsStatistics = showsStatistics
        self.shapes = shapes
        self.shapesColors = shapesColors
        self.removedGeometry = removedGeometry
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.backgroundColor = .clear
        self.showsStatistics = false
        self.shapes = [.box]
        self.shapesColors = [.red, .black]
        self.removedGeometry = { _, _ in }
        super.init(coder: coder)
    }

    // MARK: UIViewController life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else { return }
        let touchLocation = firstTouch.location(in: sceneView)
        let sceneHitResults = sceneView.hitTest(touchLocation, options: nil)
        guard let firstSceneHitResult = sceneHitResults.first else { return }

        let hitResultNode = firstSceneHitResult.node
        let hitResultGeometry = hitResultNode.geometry

        hitResultNode.removeFromParentNode()
        removedGeometry(hitResultGeometry, hitResultGeometry?.materials.first?.diffuse.contents as? UIColor)
    }

    // MARK: Private methods

    private func setup() {
        setup(
            scene: scene,
            cameraPosition: .init(x: 0, y: 5, z: 10),
            backgroundColor: backgroundColor
        )

        sceneView.backgroundColor = .clear
        sceneView.scene = scene
        sceneView.delegate = self
        sceneView.isPlaying = true
        sceneView.allowsCameraControl = false
        sceneView.autoenablesDefaultLighting = true
        sceneView.showsStatistics = showsStatistics

        view = sceneView
    }

    private func setup(
        scene: SCNScene,
        cameraPosition: SCNVector3,
        backgroundColor: UIColor
    ) {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = cameraPosition

        scene.rootNode.addChildNode(cameraNode)
        scene.background.contents = backgroundColor
    }

    private func add(
        geometry: SCNGeometry,
        with color: UIColor,
        and physicsBody: SCNPhysicsBody,
        to scene: SCNScene
    ) {
        let material = SCNMaterial()
        material.diffuse.contents = color
        geometry.materials = [material]

        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.physicsBody = physicsBody

        scene.rootNode.addChildNode(geometryNode)
    }

    private func removeChildNodes(in scene: SCNScene, with yPosition: Float) {
        for node in scene.rootNode.childNodes {
            if node.presentation.position.y < yPosition {
                node.removeFromParentNode()
            }
        }
    }
}

// MARK: - SCNSceneRendererDelegate implementation

extension GeometryFighterSceneViewController: SCNSceneRendererDelegate {

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        removeChildNodes(in: scene, with: -2)

        guard time > geometrySpawnTime else { return }

        add(
            geometry: shapes.randomElement()?.sceneGeometry ?? Shape.box.sceneGeometry,
            with: shapesColors.randomElement() ?? .white,
            and: randomPhysicsBodyWithForce,
            to: scene
        )

        geometrySpawnTime = time + TimeInterval(Float.random(in: 0.2...1.5))
    }
}
