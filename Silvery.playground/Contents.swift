/*:
# Silvery
Try out Silvery here!
*/
import Foundation
@testable import Silvery


// Lets get generic introspection working, shall we?

func pab(o: Any, offset: Int) -> UnsafePointer<Void> {
    var object = o
    return withUnsafePointer(&object) { UnsafePointer($0).advancedBy(offset) }
}

func accept<A>(a: A) {
    print(A.self)
    
    let p = pab(a, offset: 56)
    let type = UnsafePointer<UInt8>(p)
    String(type)
    type.memory
    
}

accept(("asdf", 1, true))