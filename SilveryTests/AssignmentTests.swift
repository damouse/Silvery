//
//  SilveryTests.swift
//  SilveryTests
//
//  Created by damouse on 5/4/16.
//  Copyright © 2016 I. All rights reserved.
//
//  Simple primitive assigment on a base class

import XCTest
@testable import Silvery


// Why the repetition on properties here? Based on the size in memory of a given type
// things can get a little screwy. This ordering of properties tests those specific bugs
// Floats and Booleans are the real culprits
class Dog: Silvery {
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
    
    required init() {}
}


// We can successfully write primitive types from objects
class PrimitiveAssignment: XCTestCase {
    var d = Dog()
    
    func testString() {
        d["str1"] = "str1-new"
        d["str2"] = "str2-new"
        d["str3"] = "str3-new"
        d["str4"] = "str4-new"
        
        XCTAssert(d.str1 == "str1-new")
        XCTAssert(d.str2 == "str2-new")
        XCTAssert(d.str3 == "str3-new")
        XCTAssert(d.str4 == "str4-new")
    }
    
    func testInt() {
        d["int1"] = 999
        XCTAssert(d.int1 == 999)
    }
    
    func testBool() {
        d["bool1"] = false
        XCTAssert(d.bool1 == false)
        d["bool2"] = true
        XCTAssert(d.bool2 == true)
        d["bool3"] = false
        XCTAssert(d.bool3 == false)
    }
    
    func testFloat() {
        d["flt1"] = Float(1.0)
        XCTAssert(d.flt1 == 1.0)
        d["flt2"] = Float(2.0)
        XCTAssert(d.flt2 == 2.0)
        d["flt3"] = Float(3.0)
        XCTAssert(d.flt3 == 3.0)
    }
    
    func testDouble() {
        d["double1"] = 1.0
        XCTAssert(d.double1 == 1.0)
        d["double2"] = 2.0
        XCTAssert(d.double2 == 2.0)
        d["double3"] = 3.0
        XCTAssert(d.double3 == 3.0)
    }
}


// Ensure optional assignment works without needing extra values
class Cat: Silvery {
    var str: String?
    var int: Int?
    var bool: Bool?
    var float: Float?
    var double: Double?
    
    required init() {}
}

class OptionalProperties: XCTestCase {
    func testOptionalReadability() {
        let c = Cat()
        
        XCTAssert(c.str == nil)
        XCTAssert(c.int == nil)
        XCTAssert(c.bool == nil)
        XCTAssert(c.float == nil)
        XCTAssert(c.double == nil)
    }
    
    func testOptionalString() {
        var c = Cat()
        c["str"] = "a"
        XCTAssert(c.str! == "a")
    }
    
    func testNilOptionalString() {
        let c = Cat()
        XCTAssert(c.str == nil)
    }
    
    func testOptionalInt() {
        var c = Cat()
        c["int"] = 1
        XCTAssert(c.int! == 1)
    }
    
    func testOptionalBool() {
        var c = Cat()
        c["bool"] = true
        XCTAssert(c.bool == true)
    }
    
    func testOptionalFloat() {
        var c = Cat()
        let newFloat: Float = 123.456
        c["float"] = newFloat
        XCTAssert(c.float! == newFloat)
    }
    
    func testOptionalDouble() {
        var c = Cat()
        c["double"] = 123.456
        XCTAssert(c.double! == 123.456)
    }
}


class Squirrel: Silvery {
    var str = "str"
    var int: Int?
}

// Make sure we can access type information from outside a silvery instance
class TypeProperties: XCTestCase {
    // Assigned, non-nil
    func testSimpleProperty() {
        let s = Squirrel()
        let t = try! s.typeForKey("str")
        
        XCTAssert(t == String.self)
    }
    
    func testOptionalUnassigned() {
        let s = Squirrel()
        let t = try! s.typeForKey("int")
        
        XCTAssert(t == Int.self)
    }
    
    func testOptionalAssigned() {
        let s = Squirrel()
        s.int = 1
        let t = try! s.typeForKey("int")
        
        XCTAssert(t == Int.self)
    }
}














