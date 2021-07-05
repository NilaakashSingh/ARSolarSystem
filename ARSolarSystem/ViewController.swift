//
//  ViewController.swift
//  ARSolarSystem
//
//  Created by Alogorist on 07/12/20.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var solarSceneView: ARSCNView!
    
    // MARK: - Variables
    let configuration = ARWorldTrackingConfiguration()

    // MARK: - ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        solarSceneView.session.run(configuration)
        solarSceneView.autoenablesDefaultLighting = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupSolarSystem()
    }
    
    // MARK: - UserDefined Methods
    private func setupSolarSystem() {
        let mercury = planet(geometry: SCNSphere(radius: 0.05),
                           diffuse: UIImage(named: "mercury"),
                           position: SCNVector3(0.5, .zero, .zero))
        
        let venus = planet(geometry: SCNSphere(radius: 0.1),
                           diffuse: UIImage(named: "venus"),
                           emission: UIImage(named: "venusClouds"),
                           position: SCNVector3(0.8, .zero, .zero))
        
        let earth = planet(geometry: SCNSphere(radius: 0.2),
                           diffuse: UIImage(named: "earthDay"),
                           specular: UIImage(named: "earthSpecular"),
                           emission: UIImage(named: "earthClouds"),
                           normal: UIImage(named: "earthNormal"),
                           position: SCNVector3(1.2, .zero, .zero))
        
        let mars = planet(geometry: SCNSphere(radius: 0.15),
                          diffuse: UIImage(named: "mars"),
                          position: SCNVector3(1.5, .zero, .zero))
        
        let jupiter = planet(geometry: SCNSphere(radius: 0.25),
                             diffuse: UIImage(named: "jupiter"),
                             position: SCNVector3(1.7, .zero, .zero))
        
        let saturn = planet(geometry: SCNSphere(radius: 0.22),
                             diffuse: UIImage(named: "saturn"),
                             emission: UIImage(named: "saturnRing"),
                             position: SCNVector3(2.3, .zero, .zero))
        
        let moon = planet(geometry: SCNSphere(radius: 0.05),
                             diffuse: UIImage(named: "moon"),
                             position: SCNVector3(.zero, .zero, -0.3))
        
        
        let sun = planet(geometry: SCNSphere(radius: 0.35),
                         diffuse: UIImage(named: "sun"),
                         position: SCNVector3(.zero, .zero, -1))
        
        let mercuryParentNode = getParentNode()
        let venusParentNode = getParentNode()
        let earthParentNode = getParentNode()
        let marsParentNode = getParentNode()
        let jupiterParentNode = getParentNode()
        let saturnParentNode = getParentNode()
        
        mercuryParentNode.addChildNode(mercury)
        venusParentNode.addChildNode(venus)
        earthParentNode.addChildNode(earth)
        marsParentNode.addChildNode(mars)
        jupiterParentNode.addChildNode(jupiter)
        saturnParentNode.addChildNode(saturn)
        earth.addChildNode(moon)
        
        solarSceneView.scene.rootNode.addChildNode(sun)
        solarSceneView.scene.rootNode.addChildNode(mercuryParentNode)
        solarSceneView.scene.rootNode.addChildNode(venusParentNode)
        solarSceneView.scene.rootNode.addChildNode(earthParentNode)
        solarSceneView.scene.rootNode.addChildNode(marsParentNode)
        solarSceneView.scene.rootNode.addChildNode(jupiterParentNode)
        solarSceneView.scene.rootNode.addChildNode(saturnParentNode)
            
        sun.runAction(rotate(vector: SCNVector3(.zero, 360.degreeToRadian, .zero),
                             duration: 8))
        mercury.runAction(rotate(vector: SCNVector3(.zero, 360.degreeToRadian, .zero),
                               duration: 4))
        venus.runAction(rotate(vector: SCNVector3(.zero, 360.degreeToRadian, .zero),
                             duration: 6))
        earth.runAction(rotate(vector: SCNVector3(.zero, 360.degreeToRadian, .zero),
                               duration: 5))
        mars.runAction(rotate(vector: SCNVector3(.zero, 360.degreeToRadian, .zero),
                             duration: 6))
        jupiter.runAction(rotate(vector: SCNVector3(.zero, 360.degreeToRadian, .zero),
                               duration: 7))
        saturn.runAction(rotate(vector: SCNVector3(.zero, 360.degreeToRadian, .zero),
                             duration: 8))
        
        mercuryParentNode.runAction(rotate(vector: SCNVector3(.zero, 360.degreeToRadian, .zero),
                                         duration: 4))
        venusParentNode.runAction(rotate(vector: SCNVector3(.zero, 360.degreeToRadian, .zero),
                                         duration: 7))
        earthParentNode.runAction(rotate(vector: SCNVector3(.zero, 360.degreeToRadian, .zero),
                                         duration: 14))
        marsParentNode.runAction(rotate(vector: SCNVector3(.zero, 360.degreeToRadian, .zero),
                                         duration: 17))
        jupiterParentNode.runAction(rotate(vector: SCNVector3(.zero, 360.degreeToRadian, .zero),
                                         duration: 20))
        saturnParentNode.runAction(rotate(vector: SCNVector3(.zero, 360.degreeToRadian, .zero),
                                         duration: 23))
    }
    
    private func getParentNode(vector: SCNVector3 = SCNVector3(.zero, .zero, -1)) -> SCNNode {
        let parentNode = SCNNode()
        parentNode.position = vector
        return parentNode
    }
    
    private func rotate(vector: SCNVector3, duration: TimeInterval) -> SCNAction {
        let action = SCNAction.rotateBy(x: CGFloat(vector.x),
                                        y: CGFloat(vector.y),
                                        z: CGFloat(vector.z),
                                        duration: duration)
        return SCNAction.repeatForever(action)
    }
    
    private func planet(geometry: SCNGeometry,
                        diffuse: UIImage?,
                        specular: UIImage? = nil,
                        emission: UIImage? = nil,
                        normal: UIImage? = nil,
                        position: SCNVector3) -> SCNNode {
        
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }

}


extension Int {
    var degreeToRadian: Double {
        return Double(self) * .pi/180
    }
}
