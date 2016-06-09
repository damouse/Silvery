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

class Shark: Class {
    var str: String? = "str1"
    var int = 123456
    var bool = true
    var flt: Float = 111.111
    var double: Double = 111.111
    
    var family: Pod?
    var siblings: [Shark] = []
    var parents: [String: Shark] = [:]
    
    required init() {}
}

class Pod: Class {
    var str: [String]? = ["str1"]
    var int: [Int]? = [123456]
    var bool: [Bool]? = [true]
    var flt: [Float]? = [111.111]
    var double: [Double]? = [111.111]
    
    required init() {}
}


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Testing target started")
        
//        let dict: [String: AnyObject] = ["str": "str", "int": 1, "bool": true, "float": 12.34 as! Float, "double": 56.78 as! Double]
//        // let dict: [String: AnyObject] = ["str": "str"]
//        
//        let a = try! Cat.from(dict)
//        print("Done: \(a.str) \(a.int) \(a.bool) \(a.float) \(a.double)")
//        
        
        let s = Shark()
        s.parents = ["joe": Shark(), "anne": Shark()]
        
        let json = try! serialize(s)
        
        print(getString(json.rawString()))
    }
}

// Clean up the result for readability
func getString(json: String?) -> String? {
    var s = json!
    
    s = s.stringByReplacingOccurrencesOfString("\n ", withString: "")
    s = s.stringByReplacingOccurrencesOfString("\n", withString: "")
    //s = s.stringByReplacingOccurrencesOfString("\"", withString: "\\\"")
    
    for whitespace in [" ", "  ", "   ", "    ", "     "] {
        s = s.stringByReplacingOccurrencesOfString(whitespace, withString: "")
    }
    
    return s
}

