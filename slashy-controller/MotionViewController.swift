//
//  ViewController.swift
//  slashy-controller
//
//  Created by Guanlun Zhao on 1/31/18.
//  Copyright © 2018 Guanlun Zhao. All rights reserved.
//
import UIKit
import CoreMotion

class MotionViewController: UIViewController {
    let motionManager = CMMotionManager()
    let updateInterval = 1.0 / 60.0
    let queue = OperationQueue()
    var hackFrameCount = 0
    var stabFrameCount = 0
    var blocFrameCount = 0
    let cooldown = -10
    
    var velocity = Vec3(x: 0.0, y: 0.0, z: 0.0)
    var position = Vec3(x: 0.0, y: 0.0, z: 0.0)
    
    var serverIP : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motionManager.deviceMotionUpdateInterval = updateInterval
        motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: queue, withHandler: onMotionUpdate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendRequest(payload: String?) -> Void {
        if serverIP != nil {
            var urlString = "http://\(serverIP!):9000"
            if !payload!.isEmpty {
                urlString += "?action=" + payload!
            }
            print(urlString)
            
            let url = URL(string: urlString)
            let request = URLRequest(url: url!)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: self.queue, completionHandler: { (res, data, err) in
                print(data)
            })
        }
    }
    @IBAction func jumpDown(_ sender: UIButton) {
        sendRequest(payload: "jump")
    }
    
    @IBAction func moveLeftDown(_ sender: UIButton) {
        sendRequest(payload: "leftDown")
    }
    
    @IBAction func moveLeftUp(_ sender: UIButton) {
        sendRequest(payload: "leftUp")
    }
    
    @IBAction func moveRightDown(_ sender: UIButton) {
        sendRequest(payload: "rightDown")
    }
    
    @IBAction func moveRightUp(_ sender: UIButton) {
        sendRequest(payload: "rightUp")
    }
    
    func onMotionUpdate(motion: CMDeviceMotion?, err: Error?) -> Void {
        let motion = motionManager.deviceMotion
        
        if let acc = motion?.userAcceleration {
            //            print(hackFrameCount)
            if acc.x > 0.5 {
                //print(acc.x)
                hackFrameCount += 1
                if hackFrameCount > 7 {
                    print("hack!")
                    sendRequest(payload: "hack")
                    hackFrameCount = cooldown;
                    stabFrameCount = cooldown;
                    blocFrameCount = cooldown;
                }
                //                stabFrameCount = 0
            } else if acc.y > 0.5{
                stabFrameCount += 1
                if stabFrameCount > 7 {
                    print("stab!")
                    sendRequest(payload: "stab")
                    hackFrameCount = cooldown;
                    stabFrameCount = cooldown;
                    blocFrameCount = cooldown;
                }
            } else if acc.z > 0.5{
                blocFrameCount += 1
                if blocFrameCount > 7 {
                    print("bloc!")
                    sendRequest(payload: "block")
                    hackFrameCount = cooldown;
                    stabFrameCount = cooldown;
                    blocFrameCount = cooldown;
                }
            }
            else{
                if hackFrameCount > 0 {
                    hackFrameCount = 0
                } else {
                    hackFrameCount += 1
                }
                if stabFrameCount > 0 {
                    stabFrameCount = 0
                } else {
                    stabFrameCount += 1
                }
                if blocFrameCount > 0 {
                    blocFrameCount = 0
                } else {
                    blocFrameCount += 1
                }
            }
            //
            //            if acc.y > 0.15 {
            //                stabFrameCount += 1
            //                if stabFrameCount > 15 {
            //                    print("stab!")
            //                    sendRequest(payload: "stab")
            //                    hackFrameCount = cooldown
            //                    stabFrameCount = cooldown
            //                }
            //                hackFrameCount = 0
            //            } else {
            //                stabFrameCount = 0
            //            }
            
            //            let acceleration = Vec3(x: acc.x, y: acc.y, z: acc.z)
            //
            //            self.velocity.add(v: Vec3.scalarMult(scalar: updateInterval, vec: acceleration))
            //            self.position.add(v: Vec3.scalarMult(scalar: updateInterval, vec: self.velocity))
            //
            //            print(String(describing: self.velocity))
        }
    }
}
