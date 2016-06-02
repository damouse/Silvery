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
print(t!.dynamicType)
