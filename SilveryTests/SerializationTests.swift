//
//  SerializationTests.swift
//  Silvery
//
//  Created by damouse on 6/9/16.
//  Copyright © 2016 I. All rights reserved.
//
//
//  NOTE: these tests are actually from DSON, but were written here when the circular dependancy issue made things tough


import XCTest
@testable import Silvery

class Shark: Class {
    var str = "str1"
    var int = 123456
    var bool = true
    var flt: Float = 111.111
    var double: Double = 111.111
    
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


class SerializationTests: XCTestCase {
    // This test *does not work*. The resulting nil is never passed through to the json string!
//    func testNil() {
//        let f = Pod()
//        f.str = nil
//        let json = try! serialize(f)
//        
//        XCTAssert(json["str"].type == .Null)
//
//    }
    
    func testPrimitiveObject() {
        let f = Shark()
        let json = try! serialize(f)
        
        XCTAssert(json.rawString()! == "{\n  \"str\" : \"str1\",\n  \"int\" : 123456,\n  \"bool\" : true,\n  \"flt\" : 111.111,\n  \"double\" : 111.111\n}")
    }
    
    func testPrimitiveArrays() {
        let f = Pod()
        let json = try! serialize(f)
        
        XCTAssert(json.rawString() == "{\n  \"str\" : [\n    \"str1\"\n  ],\n  \"int\" : [\n    123456\n  ],\n  \"bool\" : [\n    true\n  ],\n  \"flt\" : [\n    111.111\n  ],\n  \"double\" : [\n    111.111\n  ]\n}")
    }
}
