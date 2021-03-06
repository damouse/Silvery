//
//  Property.swift
//  Dynamic
//
//  Created by Bradley Hilton on 7/20/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

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
    
    // Attempt to cast some value to this type
    public static func cast(from: Any) -> Self? {
        return from as? Self
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
