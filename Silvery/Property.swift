//
//  Property.swift
//  Dynamic
//
//  Created by Bradley Hilton on 7/20/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import DSON

// All model properties must conform to this protocol
public protocol Property {}

extension Property {
    
    static func size() -> Int {
        return sizeof(self)
    }
    
    static func align() -> Int {
        return alignof(self)
    }
    
    static func type() -> Self.Type.Type {
        return self.dynamicType
    }
    
    mutating func codeInto(pointer: UnsafePointer<Void>) {
        (UnsafeMutablePointer(pointer) as UnsafeMutablePointer<Self>).memory = self
    }
    
    mutating func codeOptionalInto(pointer: UnsafePointer<Void>) {
        (UnsafeMutablePointer(pointer) as UnsafeMutablePointer<Optional<Self>>).memory = self
    }
    
    // Unfortunatly this has to be here, since we can't reliably pass out this property's type information
    static func convert<A>(from: A) throws -> Self? {
        // return convert(from, to: Self.self)

        if let cast = from as? Self {
            return cast
        }
        
        if let convertible = Self.self as? Convertible.Type {
            print("Property.convert has a convertible")
            return try convertible.from(from) as! Self
        }
        
        throw ConversionError.NoConversionPossible(from: A.self, type: Self.self)
    }
}

protocol OptionalProperty : Property {
    static func codeNilInto(pointer: UnsafePointer<Void>)
    static func propertyType() -> Property.Type?
    func property() -> Property?
}

extension Optional : OptionalProperty {
    
    static func codeNilInto(pointer: UnsafePointer<Void>) {
        (UnsafeMutablePointer(pointer) as UnsafeMutablePointer<Optional>).memory = nil
    }
    
    static func propertyType() -> Property.Type? {
        return Wrapped.self as? Property.Type
    }
    
    func property() -> Property? {
        switch self {
        case .Some(let property):
            if let property = property as? Property {
                return property
            } else {
                return nil
            }
        default: return nil
        }
    }
}


// Just testing, thanks
//public func testGeneric <A: Property>(from: Any, type: A.Type) throws -> A? {
//    if let convertible = A.self as? Convertible.Type {
//        return try convertible.from(from) as! A
//    }
//    
//    return nil
//}

