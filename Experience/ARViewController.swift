//
//  ViewController.swift
//  Experience
//
//  Created by Ashutosh Mane on 17/01/20.
//  Copyright © 2020 Ashutosh Mane. All rights reserved.
//

import UIKit
import RealityKit
import ARKit

class ARViewController: UIViewController {
    
  
    
    @IBOutlet var experienceARView: ARView!
    @IBOutlet var reloadARSceneBtn:UIButton!
    @IBOutlet var showARCollectionBtn:UIButton!
    @IBOutlet weak var ARModeSegmentedControl: UISegmentedControl!
    @IBAction func segmentChanged(_ sender: Any) {
        segmentedValueChanged(for: self.ARModeSegmentedControl)
    }
    
    var demoAnchor:Demo.DemoScene?
    var coachingOverlay:ARCoachingOverlayView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    fileprivate func setupCollectionMenuBtn() {
        self.showARCollectionBtn.addTarget(self, action: #selector(presentARCollection), for: .touchUpInside)
    }
    
    fileprivate func setupResetMenuBtn() {
        self.reloadARSceneBtn.addTarget(self, action: #selector(resetARScene), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupARView()
        setupCollectionMenuBtn()
        setupResetMenuBtn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        configureARSession()
    }
    
    
    //MARK: SetupARSession
    func setupARView(){
        self.experienceARView.translatesAutoresizingMaskIntoConstraints=false
        self.experienceARView.pinEdges(to: super.view)
        self.experienceARView.session.delegate=self
    }
    
    
    func configureARSession() {
 
        self.experienceARView.automaticallyConfigureSession=false
        let configuration=ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.environmentTexturing = .automatic
        self.experienceARView.session.run(configuration)
        coachingOverlay=ARCoachingOverlayView(frame: experienceARView.frame)
        self.experienceARView.addSubview(coachingOverlay)
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.session = self.experienceARView.session
        self.experienceARView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(findAnchor(recognizer:))))
        
    }
    
    
    @objc func resetARScene(){
        print("reset tapped")
        experienceARView.scene.anchors.removeAll()
    }
    
    //segmented control
    func segmentedValueChanged(for control:UISegmentedControl){
        switch ARModeSegmentedControl.selectedSegmentIndex{
        case 0:
            print("normal mode")
            
        case 1:
            print("go insane")
            
            
        default:
            print("default")
        }
        
    }
    
   //show AR collection
    @objc func presentARCollection(){
        let CollectionVC = self.storyboard?.instantiateViewController(identifier: "ARCV")
        self.present(CollectionVC!, animated: true) {
            print("presented second VC")
        }
    }
  
    @objc func findAnchor(recognizer:UITapGestureRecognizer){
        
        let location=recognizer.location(in: experienceARView)
        
        let raycastResults=experienceARView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        
        guard let firstRayCastResult = raycastResults.first else {
            print("raycast could not find plane")
            return
        }
        print("raycast found")
        let anchor=ARAnchor(name: "House", transform: firstRayCastResult.worldTransform)
        
    }
    
    func placeObjects(of name:String, on anchor:ARAnchor){
        let entity=ModelEntity.En
    }
}



extension ARViewController:ARSessionDelegate{
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        
        
        for anchor in anchors{
            if let anchorName = anchor.name, anchor.name=="House"{
                placeObject(name:anchorName, anchor:anchor)
            }
        }
    }
}


