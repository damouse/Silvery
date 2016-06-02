/*:
# Silvery
Try out Silvery here!
*/
import Foundation
@testable import Silvery

class Squirrel: Silvery {
    var str = "str"
    var int: Int?
}

let s = Squirrel()

let t = try! s.typeForKey("int")
print(t)


for child in s.mirroredChildren() {
    if child.label == "int" {
        if let optionalPropertyType = child.value.dynamicType as? OptionalProperty.Type, let propertyType = optionalPropertyType.propertyType() {
            print(propertyType)
        } else if let property = child.value as? Property {
            print(property.dynamicType)
        } else {
            print("Nothing")
        }
    }
}