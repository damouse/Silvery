//
//  StructAssignmentTests.swift
//  Silvery
//
//  Created by Mickey Barboi on 6/21/16.
//  Copyright © 2016 I. All rights reserved.
//

import XCTest
@testable import Silvery

// Why the repetition on properties here? Based on the size in memory of a given type
// things can get a little screwy. This ordering of properties tests those specific bugs
// Floats and Booleans are the real culprits
struct Pigeon: Silvery {
    var str1 = "str1"
    var int1 = 123456
    
    var bool1 = true
    var bool2 = false
    var bool3 = true
    
    var str2 = "str2"
    
    var flt1: Float = 111.111
    var flt2: Float = 222.222
    var flt3: Float = 333.333
    
    var str3 = "str3"
    
    var double1: Double = 111.111
    var double2: Double = 222.222
    var double3: Double = 333.333
    
    var str4 = "str4"
}


// Triggers a swift assignment bug, on hold
class StructAssignmentTests: XCTestCase {
    var d = Pigeon()
    
    func testString() {
//        d["str1"] = "str1-new"
//        d["str2"] = "str2-new"
//        d["str3"] = "str3-new"
//        d["str4"] = "str4-new"
        
//        XCTAssert(d.str1 == "str1-new")
//        XCTAssert(d.str2 == "str2-new")
//        XCTAssert(d.str3 == "str3-new")
//        XCTAssert(d.str4 == "str4-new")
    }
}
    