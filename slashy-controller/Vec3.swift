//
//  Vec3.swift
//  slashy-controller
//
//  Created by Guanlun Zhao on 2/21/18.
//  Copyright © 2018 Guanlun Zhao. All rights reserved.
//

import Foundation

class Vec3: CustomStringConvertible {
    var x = 0.0
    var y = 0.0
    var z = 0.0
    
    init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    func add(v: Vec3) {
        self.x += v.x
        self.y += v.y
        self.z += v.z
    }
    
    func length() -> Double {
        return sqrt(x * x + y * y + z * z)
    }
    
    static func scalarMult(scalar: Double, vec: Vec3) -> Vec3 {
        return Vec3(x: vec.x * scalar, y: vec.y * scalar, z: vec.z * scalar)
    }
    
    static func add(v1: Vec3, v2: Vec3) -> Vec3 {
        return Vec3(x: v1.x + v2.x, y: v1.y + v2.y, z: v1.z + v2.z)
    }
    
    public var description: String {
        let xs = String(format: "%.3f", self.x)
        let ys = String(format: "%.3f", self.y)
        let zs = String(format: "%.3f", self.z)
        
        return "x: \(xs)  y: \(ys)  z:\(zs)"
    }
}
