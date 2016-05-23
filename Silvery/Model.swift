//
//  Model.swift
//  Dynamic
//
//  Created by Bradley Hilton on 7/20/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

/*
 
 The following is taken from the Swift ABI found here: https://github.com/apple/swift/blob/master/docs/ABI.rst#type-metadata
 
 Structs and tuples currently share the same layout algorithm, noted as the "Universal" layout algorithm in the compiler implementation. The algorithm is as follows:
 
 Start with a size of 0 and an alignment of 1.
 Iterate through the fields, in element order for tuples, or in var declaration order for structs. For each field:
 Update size by rounding up to the alignment of the field, that is, increasing it to the least value greater or equal to size and evenly divisible by the alignment of the field.
 Assign the offset of the field to the current value of size.
 Update size by adding the size of the field.
 Update alignment to the max of alignment and the alignment of the field.
 
 The final size and alignment are the size and alignment of the aggregate. The stride of the type is the final size rounded up to alignment.
 */

/**
    Enables dynamic, KVC-style behavior for native Swift classes and structures.

    Keep in mind the following caveats:
    - All properties must conform to the Property protocol
    - Properties may not be implicitly unwrapped optionals
*/

// Magic numbers for offsetting into objects
let WORD_SIZE = 8
let DEFAULT_CLASS_OFFSET = 2


public protocol Silvery : Property {}

extension Silvery {

    public subscript (key: String) -> Property? {
        get {
            do {
                return try valueForKey(key)
            } catch {
                return nil
            }
        }
        set {
            do {
                try setValue(newValue, forKey: key)
            } catch let e {
                print("Failed to set \(key). Error: \(e)")
            }
        }
    }
    
    // Return all property names as a list of strings
    public func keys() -> [String] {
        return mirroredChildren().filter({ $0.label != nil }).map { $0.label! }
    }
    
    // Return all properties as a list of mirrored elements. These are aliased as (String, Any)
    func mirroredChildren() -> [Mirror.Child] {
        // Collect supeclass fields. Relative ordering is important!
        var ancestor: Mirror? = Mirror(reflecting: self)
        var properties: [Mirror.Child] = []
        
        while ancestor != nil {
            var kids = ancestor!.children.map {$0}
            kids.appendContentsOf(properties)
            properties = kids
            ancestor = ancestor?.superclassMirror()
        }
        
        return properties
    }
    
    public mutating func setValue(value: Property?, forKey key: String) throws {
        var offset = WORD_SIZE * DEFAULT_CLASS_OFFSET
        let properties = mirroredChildren()
        
        // Look for the target property
        for child in properties {
            guard let property = child.value.dynamicType as? Property.Type else { throw Error.TypeDoesNotConformToProperty(type: child.value.dynamicType) }
            
            // *Always* have to check up on the alignment of the current field before using the offset variable
            let align = property.align()
            
            // The offset of this field must be a multiple of its alignment, but offset is incremented
            // based on the size of the previous field-- pad as needed
            if offset % align != 0 {
                offset += align - ((offset + align) % align)
            }
            
            // If found then grab a pointer to the child's memory and attempt to write in the new value
            if child.label == key {
                let pointer = pointerAdvancedBy(offset)
                
                if let optionalPropertyType = child.value.dynamicType as? OptionalProperty.Type, let propertyType = optionalPropertyType.propertyType() {
                    if var optionalValue = value {
                        try x(optionalValue, isY: propertyType)
                        optionalValue.codeOptionalInto(pointer)
                    } else if let nilValue = child.value.dynamicType as? OptionalProperty.Type {
                        nilValue.codeNilInto(pointer)
                    }
                } else if var sureValue = value {
                    try x(sureValue, isY: child.value.dynamicType)
                    sureValue.codeInto(pointer)
                }
            } else {
                offset += property.size()
            }
        }
    }
    
    public func valueForKey(key: String) throws -> Property? {
        for child in mirroredChildren() {
            if child.label == key && String(child.value) != "nil" {
                
                if let property = child.value as? OptionalProperty {
                    return property.property()
                } else if let property = child.value as? Property {
                    return property
                } else {
                    throw Error.TypeDoesNotConformToProperty(type: child.value.dynamicType)
                }
            }
        }
        
        return nil
    }
    
    mutating func pointerAdvancedBy(offset: Int) -> UnsafePointer<Void> {
        if let object = self as? AnyObject {
            return UnsafePointer(bitPattern: unsafeAddressOf(object).hashValue).advancedBy(offset)
        } else {
            return withUnsafePointer(&self) { UnsafePointer($0).advancedBy(offset) }
        }
    }
}



func x(x: Any, isY y: Any.Type) throws {
    if x.dynamicType == y {
    } else if let x = x as? AnyObject, let y = y as? AnyClass where x.isKindOfClass(y) {
    } else {
        throw Error.CannotSetTypeAsType(x: x.dynamicType, y: y)
    }
}

// We must create two seperate kinds of object here
// i think this belongs in DSON, not here. This is a library for access based on keys, not conversion to and from DSON
// But what about "all keys," ignore functions, etc?
public class SilveryClass: Silvery {
    public required init() { }
}








