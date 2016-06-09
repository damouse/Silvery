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

// Please replace these with more sane tests
//    func testPrimitiveObject() {
//        let f = Shark()
//        let json = try! serialize(f)
//        
//        XCTAssert(json.rawString()! == "{\n  \"str\" : \"str1\",\n  \"int\" : 123456,\n  \"bool\" : true,\n  \"flt\" : 111.111,\n  \"double\" : 111.111\n}")
//    }
//    
//    func testPrimitiveArrays() {
//        let f = Pod()
//        let json = try! serialize(f)
//        
//        XCTAssert(json.rawString() == "{\n  \"str\" : [\n    \"str1\"\n  ],\n  \"int\" : [\n    123456\n  ],\n  \"bool\" : [\n    true\n  ],\n  \"flt\" : [\n    111.111\n  ],\n  \"double\" : [\n    111.111\n  ]\n}")
//    }
//    
//    func testNestedObject() {
//        let s = Shark()
//        s.family = Pod()
//        
//        let json = try! serialize(s)
//        XCTAssert(json.rawString() == "{\n  \"str\" : \"str1\",\n  \"int\" : 123456,\n  \"bool\" : true,\n  \"flt\" : 111.111,\n  \"double\" : 111.111,\n  \"family\" : {\n    \"str\" : [\n      \"str1\"\n    ],\n    \"int\" : [\n      123456\n    ],\n    \"bool\" : [\n      true\n    ],\n    \"flt\" : [\n      111.111\n    ],\n    \"double\" : [\n      111.111\n    ]\n  }\n}")
//    }
//    
//    func testObjectArray() {
//        let s = Shark()
//        s.family = Pod()
//        s.siblings = [Shark(), Shark()]
//        
//        let json = try! serialize(s)
//        XCTAssert(getString(json.rawString()) == "{\"str\":\"str1\",\"int\":123456,\"bool\":true,\"flt\":111.111,\"double\":111.111,\"siblings\":[{\"str\":\"str1\",\"int\":123456,\"bool\":true,\"flt\":111.111,\"double\":111.111,\"siblings\":[]},{\"str\":\"str1\",\"int\":123456,\"bool\":true,\"flt\":111.111,\"double\":111.111,\"siblings\":[]}]}")
//    }
    
//    func testObjectDictionary() {
//        let s = Shark()
//        s.parents = ["joe": Shark(), "anne": Shark()]
//        
//        let json = try! serialize(s)
//        
//        print(getString(json.rawString()))
//    }
}


// Clean up the result for readability
func getString(json: String?) -> String {
    var s = json!
    
    s = s.stringByReplacingOccurrencesOfString("\n", withString: "")
    
    for whitespace in [" ", "  ", "   ", "    ", "     "] {
        s = s.stringByReplacingOccurrencesOfString(whitespace, withString: "")
    }
    
    return s
}


