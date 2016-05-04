/*:
# Silvery
Try out Silvery here!
*/
import Foundation
@testable import Silvery

class Base {
    var baseStr = "baseStr"
}

class Dog: Base, Model {
    let q = "constant"
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
    
    override init() {}
}

var d = Dog()

d.baseStr
d["baseStr"] = "Hello!"
d.baseStr