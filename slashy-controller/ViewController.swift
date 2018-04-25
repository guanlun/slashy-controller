//
//  ViewController.swift
//  slashy-controller
//
//  Created by Guanlun Zhao on 1/31/18.
//  Copyright © 2018 Guanlun Zhao. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var ipAddressField: UITextField!
    @IBAction func connectToServer(_ sender: Any) {        
//        serverIP = ipAddressField.text
        performSegue(withIdentifier: "openMotionView", sender: nil)
    }

    @IBAction func testRequest(_ sender: Any) {
        print("requesting")
        let url = URL(string: "http://10.230.240.238:9000")
        let request = URLRequest(url: url!)
        
        NSURLConnection.sendAsynchronousRequest(URLRequest(url: url!), queue: OperationQueue(), completionHandler: { (res, data, err) in
            print(res)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        motionManager.deviceMotionUpdateInterval = updateInterval
//        motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: queue, withHandler: onMotionUpdate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openMotionView" {
            let segueVC = segue.destination as! MotionViewController
            
            segueVC.serverIP = ipAddressField.text
        }
    }

    
}

