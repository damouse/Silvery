//
//  JsonTests.swift
//  Silvery
//
//  Created by damouse on 5/24/16.
//  Copyright © 2016 I. All rights reserved.
//

import XCTest
@testable import Silvery


//// Silvery-- the general case that lacks fromDictionary
//class Animal: Silvery {
//    var a = "str"
//    var b = 1
//}
//
//class Squirrel: Animal {
//    var c = false
//    var d: Float = 123.456
//    var e: Double = 789.123
//}
//
//class JsonTests: XCTestCase {
//    // Make sure all keys come across 
//    func testKeys() {
//        let d = Squirrel()
//        XCTAssert(d.keys == ["a", "b", "c", "d", "e"])
//    }
//    
//    // Json representation is correct
//    func testToJson() {
//        let d = Squirrel()
//        
//        XCTAssert(d.json["a"] as! String == "str")
//        XCTAssert(d.json["b"] as! Int == 1)
//        XCTAssert(d.json["c"] as! Bool == false)
//        XCTAssert(d.json["d"] as! Float == 123.456)
//        XCTAssert(d.json["e"] as! Double == 789.123)
//    }
//}
