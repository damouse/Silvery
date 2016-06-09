//
//  ViewController.swift
//  Testingtarget
//
//  Created by damouse on 6/6/16.
//  Copyright © 2016 I. All rights reserved.
//

import UIKit
import Silvery

class Cat: Class {
    var str: String?
    var int: Int?
    var bool: Bool?
    var float: Float?
    var double: Double?
    
    var nested: Cat?
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Testing target started")
        
        let dict: [String: AnyObject] = ["str": "str", "int": 1, "bool": true, "float": 12.34 as! Float, "double": 56.78 as! Double]
        // let dict: [String: AnyObject] = ["str": "str"]
        
        let a = try! Cat.from(dict)
        print("Done: \(a.str) \(a.int) \(a.bool) \(a.float) \(a.double)")
        
        
        
    }
}

