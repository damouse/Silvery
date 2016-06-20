//
//  ViewController.swift
//  Testingtarget
//
//  Created by damouse on 6/6/16.
//  Copyright © 2016 I. All rights reserved.
//

import UIKit
import Silvery

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
        
        class Dolphin: Class {
            var age = 14
        }
        
        class Pod: Class {
            var members: [String: Dolphin] = ["bill": Dolphin(), "steve": Dolphin()]
        }
        
        let json = try! serialize(Pod())
        let str = json.rawString(options: NSJSONWritingOptions())
        
        print(str)
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

