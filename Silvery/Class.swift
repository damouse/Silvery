//
//  Class.swift
//  Silvery
//
//  Created by damouse on 6/6/16.
//  Copyright © 2016 I. All rights reserved.
//

import Foundation
import DSON

public class Class: Silvery, Property {
    
    // All subclasses must be initializable without arguments so silvery can do its work
    required public init() {}
    
    // Return a list of keys that *will not be touched* when converting to and from json
    // ALWAYS call the superclass method when subclassing!
    public static func ignoreProperties() -> [String] {
        return []
    }
    
    // Reflects differences betweeen property names on dynamicTypedynamicTypethis class and resulting json
    // For example, if this class has a property called "name":
    //
    //      var name: String = "anyrandomname"
    //
    // but the corresponding json key should be "firstName":
    //
    //      { "firstName": "anyrandomname" }
    //
    // then this method should return the swift dictionary:
    //
    //      ["name": "firstName"]
    //
    // That is the swift property names and their corresponding json names.
    // If the property does not exist or appears in the list returned by ignoreProperties then nothing is done.
    // The mapping occurs both ways: from json to object and from object to json.
    //
    // ALWAYS call the superclass method when subclassing!
    public static func propertyKeysToJson() -> [String: String] {
        return [:]
    }
}

extension Class: Convertible {
    
    public static func from<T>(from: T) throws -> Self {
        // Automatically cover cases where "from" is not the correct type
        let json = try DSON.convert(from, to: [String: AnyObject].self)
        print("Have json: \(json)")
        
        let ignored = ignoreProperties()
        let transformed = propertyKeysToJson()
        
        // Instantiate self and assign values to it. Strangely the reference to "object" is not recognized as conforming to silvery without an explicit cast
        var object = self.init()
        var silveryReference = object as! Silvery
        
        for k in silveryReference.keys() {
            // print("Object key: \(k)")
            
            if ignored.contains(k) { continue }
            
            // This is the name of the property. It could be switched out for another value based on propertyKeysToJson
            var propertyName = k
            
            for (propertyKey, jsonKey) in transformed {
                if jsonKey == propertyName {
                    propertyName = propertyKey
                    break
                }
            }
            
            // Get the new value from the json, get the type information from the silvery object, and make sure the new value is the correct type
            guard let newValue = json[propertyName] else { break }
            
            // Grab the property and cast it as a property
            guard let type = try silveryReference.typeForKey(propertyName), property = type as? Property.Type else { break }
            
            // Lets us remove the DSON - Silvery circular dependency crap
            // let cast = property.cast(newValue)
            // print("Able to cast value to: \(cast.dynamicType)")
            
            // if let isConvertible = property.castAs(Convertible.Type.self) {
            //    print("Able to retrieve convertible type \(isConvertible)")
            // }
            
            let converted = try property.convert(newValue)
            try silveryReference.setValue(converted, forKey: propertyName)
        }
        
        return object
    }
    
    public func serialize() throws -> AnyObject {
        var ret: [String: AnyObject] = [:]
        
        for k in self.keys() {
            var value = self[k]
            
            if let convertible = value as? Convertible {
                ret[k] = try convertible.serialize()
                // print("Assigned \(k) == \(ret[k])")
            } else {
                // Make sure this doesn't go to hell, may have to throw out of here
                ret[k] = value as! AnyObject?
            }
        }
        
        return ret as! AnyObject
    }
}


// Fake imports to allow testing of DSON object methods
import SwiftyJSON

// Performs two steps: serializes "from" to some json-ready form, and converts that serialized form to JSON
// This serialization mostly means turning objects and structs into Dictionaries recursively
// Returns a SwiftyJSON object. Raw JSON can be retrieved by accessing .rawData on the result
public func serialize(from: AnyObject) throws -> JSON {
    return try DSON.serialize(from)
}



















