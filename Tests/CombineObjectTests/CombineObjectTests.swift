import XCTest
@testable import CombineObject

final class CombineObjectTests: XCTestCase {
    @CombineObjectBind(0,CombineGlobalKey(key: "age"))
    var age:Int
    
    @CombineObjectBind(0,CombineGlobalKey(key: "age"))
    var age1:Int
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        
        self.$age.monitorValueChanged { value in
            print("age \(value)")
        }
        
        self.$age.monitorValueChanged { value in
            print("age \(value)")
        }
        
        self.$age1.monitorValueChanged { value in
            print("age1 \(value)")
        }
        
        self.$age1.monitorValueChanged { value in
            print("age1 \(value)")
        }
        
        self.$age.bind(UIView()) { v, value in
            print("\(v) \(value)")
        }
        
        print(self.age)
        print(self.age1)
        self.age = 2
        print(self.age)
        print(self.age1)
        self.age = 3
        
        
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

