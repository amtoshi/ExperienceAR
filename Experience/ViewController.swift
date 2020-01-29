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

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    @IBOutlet weak var resetAR: UIImageView!
    
    @IBOutlet weak var weekSegment: UISegmentedControl!
    
    @IBAction func segmentChanged(_ sender: Any) {
        segmentedValueChanged(for: self.weekSegment)
    }
    
    var demoAnchor:Demo.DemoScene?
    var coachingOverlay:ARCoachingOverlayView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loadARView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetARBtn()
        //                 Load the "Box" scene from the "Experience" Reality File
        
        demoAnchor=try! Demo.loadDemoScene()
        
        
        
        
        // Add the box anchor to the scene
        //               arView.scene.anchors.append(boxAnchor)
        arView.scene.anchors.append(demoAnchor!)
    }
    
    func resetARBtn(){
        self.resetAR.isUserInteractionEnabled=true
        let tap=UITapGestureRecognizer.init(target: self, action: #selector(tapReset))
        resetAR.addGestureRecognizer(tap)
        
    }
    
    func loadARView() {
        
        //configuration of the ARView
        arView.automaticallyConfigureSession=false
        let configuration=ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
        //tap gesture
        let tap=UITapGestureRecognizer.init(target: self, action: #selector(ARTaphandler(forTap:)))
        arView.addGestureRecognizer(tap)
        coachingOverlay=ARCoachingOverlayView(frame: arView.frame)
        self.arView.addSubview(coachingOverlay)
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.session = self.arView.session
        
        
    }
    
    
    @objc func tapReset(){
        print("reset tapped")
        
        
        
        
    }
    
    //segmented control
    func segmentedValueChanged(for control:UISegmentedControl){
        switch weekSegment.selectedSegmentIndex{
        case 0:
            print("normal mode")
            demoAnchor!.notifications.normal.post()
        case 1:
            print("go insane")
            
            demoAnchor!.notifications.insane.post()
        default:
            print("default")
        }
        
    }
    
    //ARTapHandler
    @objc func ARTaphandler(forTap:UITapGestureRecognizer){
        let location=forTap.location(in: arView)
        //        locatePlaneFromPointInAR(fromPoint: location)
        
        
    }
    
    func locatePlaneFromPointInAR(fromPoint:CGPoint){
        let results=arView.raycast(from: fromPoint, allowing: .estimatedPlane, alignment: .horizontal)
        
        
        
    }
    
    
}





