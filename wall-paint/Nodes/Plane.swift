//
//  Plane.swift
//  wall-paint
//
//  Created by André Schueda on 08/10/21.
//

import ARKit

class Plane: SCNNode {
    
    let extentNode: SCNNode
    var classificationNode: SCNNode?
    
    /// - Tag: VisualizePlane
    init(anchor: ARPlaneAnchor, in sceneView: ARSCNView) {
        
        #if targetEnvironment(simulator)
        #error("ARKit is not supported in iOS Simulator. Connect a physical iOS device and select it as your Xcode run destination, or select Generic iOS Device as a build-only destination.")
        #else
        
        // Create a node to visualize the plane's bounding rectangle.
        let extentPlane: SCNPlane = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        extentNode = SCNNode(geometry: extentPlane)
        extentNode.simdPosition = anchor.center
        
        // `SCNPlane` is vertically oriented in its local coordinate space, so
        // rotate it to match the orientation of `ARPlaneAnchor`.
        extentNode.eulerAngles.x = -.pi / 2

        super.init()

        self.setupExtentVisualStyle()
        addChildNode(extentNode)
        #endif
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupExtentVisualStyle() {
        // Make the extent visualization semitransparent to clearly show real-world placement.
        extentNode.opacity = 0.7

        guard let material = extentNode.geometry?.firstMaterial
            else { fatalError("SCNPlane always has one material") }
        
        material.diffuse.contents = UIColor.appLightGolden
    }
    
    private func makeTextNode(_ text: String) -> SCNNode {
        let textGeometry = SCNText(string: text, extrusionDepth: 1)
        textGeometry.font = UIFont(name: "Futura", size: 75)

        let textNode = SCNNode(geometry: textGeometry)
        // scale down the size of the text
        textNode.simdScale = float3(0.0005)
        
        return textNode
    }
}
