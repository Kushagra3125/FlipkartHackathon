//
//  ViewController.swift
//  FlipkartHackathon
//
//  Created by Kushagra Sharma on 09/07/22.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var imageName:String = "";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(imageName)
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("appear")
        let configuration = ARImageTrackingConfiguration()
        guard let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "ARPhotos", bundle: Bundle.main) else{
            print("No Images Available")
            return
        }
        configuration.trackingImages = trackedImages
        configuration.maximumNumberOfTrackedImages = 2
        configuration.frameSemantics.insert(.personSegmentationWithDepth)

        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("disappear")
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor{
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents = UIColor(red: 1, green: 0, blue: 0, alpha: 0)
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.y  = .pi/2
            node.addChildNode(planeNode)
            var watchScene = SCNScene()
            print("art.scnassets/\(imageName).usdz")
            if let safePlantScene = SCNScene(named: "art.scnassets/\(imageName).usdz"){
                watchScene = safePlantScene
            }
            let watchNode = watchScene.rootNode.childNodes.first!
            
            
            planeNode.addChildNode(watchNode)
            
        }
        return node
    }
    
    

    // MARK: - ARSCNViewDelegate
 
    
    
}
