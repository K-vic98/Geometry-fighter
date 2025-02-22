//
//  Shape.swift
//  Geometry fighter
//
//  Created by Виктор Куделин on 03.02.2025.
//

import SceneKit
import Foundation

enum Shape {
    case box
    case sphere
    case pyramid
    case torus
    case capsule
    case cylinder
    case cone
    case tube

    var sceneGeometry: SCNGeometry {
        switch self {
        case .box:
            return SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        case .sphere:
            return SCNSphere(radius: 0.5)
        case .pyramid:
            return SCNPyramid(width: 1.0, height: 1.0, length: 1.0)
        case .torus:
            return SCNTorus(ringRadius: 0.5, pipeRadius: 0.25)
        case .capsule:
            return SCNCapsule(capRadius: 0.3, height: 2.5)
        case .cylinder:
            return SCNCylinder(radius: 0.3, height: 2.5)
        case .cone:
            return SCNCone(topRadius: 0.25, bottomRadius: 0.5, height: 1.0)
        case .tube:
            return SCNTube(innerRadius: 0.25, outerRadius: 0.5, height: 1.0)
        }
    }
}
