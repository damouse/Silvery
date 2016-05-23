/*:
# Silvery
Try out Silvery here!
*/
import Foundation
@testable import Silvery

class Cat: SilveryClass {
    var str: String
    
    init(name: String) {
        str = name
    }
    
    required init() {
        str = "asdf"
    }
}

// Lets get generic introspection working, shall we?
var c = Cat(name: "Hello!")

c["str"] = "There"

print(c.str)

