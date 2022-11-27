//
//  ViewController.swift
//  SceneKit Lighting and UV
//
//  Created by John Marstall on 3/9/18.
//  Copyright © 2018 Black Pixel. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: SCNView!
    var shirtNode : SCNNode = SCNNode()
    var arrLegs : [SCNNode] = []
    var arrTShirt : [SCNNode] = []

    @IBOutlet weak var btnShirt: UIButton!
    @IBOutlet weak var btnPants: UIButton!
    @IBOutlet weak var btnSweater: UIButton!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.defaultCameraController.maximumVerticalAngle = 0.001


        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ttboy.scn")!
        scene.background.contents =  UIImage(named: "moon")


        print(scene.rootNode.childNodes[1].childNodes)

        for item in scene.rootNode.childNodes[1].childNodes {
            if item.name == "TTBJacket" {
                self.shirtNode = item
            }
            if item.name == "TTBLegsLA" || item.name == "TTBLegsLB" || item.name == "TTBLegsLC" || item.name == "TTBLegsLD" || item.name == "TTBLegsSA" || item.name == "TTBLegsSB" {
                self.arrLegs.append(item)
            }

            if item.name == "TTBSweater" {
                self.arrTShirt.append(item)
            }


//            if item.name == "TTBTshirtLA" || item.name == "TTBTshirtLAB" || item.name == "TTBTshirtLC" || item.name == "TTBTshirtSA" || item.name == "TTBTshirtSB" || item.name == "TTBTshirtSC" {
//                self.arrTShirt.append(item)
//            }


        }

        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    @IBAction func btnClothSelectionClick(_ sender: UIButton) {
        let obj:SelectionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
        obj.delegate = self
        obj.selectedType = sender.tag
        self.present(obj, animated: true)
    }

    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

extension ViewController : SelectionDeleagte {
    func sendImageDataWithIndex(index: Int, image: String) {
        if index == 1 {
            btnShirt.setBackgroundImage(UIImage(named: image), for: .normal)
            self.shirtNode.childNodes[0].geometry?.firstMaterial?.diffuse.contents = UIImage(named: image)
        } else if index == 2 {
            btnPants.setBackgroundImage(UIImage(named: image), for: .normal)
            for item in self.arrLegs {
                item.childNodes[0].geometry?.firstMaterial?.diffuse.contents = UIImage(named: image)
            }
        } else if index == 3 {
            btnSweater.setBackgroundImage(UIImage(named: image), for: .normal)
            for item in self.arrTShirt {
                item.childNodes[0].geometry?.firstMaterial?.diffuse.contents = UIImage(named: image)
            }
        }
    }
}
