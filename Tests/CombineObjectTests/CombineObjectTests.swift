import XCTest
@testable import CombineObject

final class CombineObjectTests: XCTestCase {
    
    @CombineObjectOptionalBind([])
    var list:[String]?
    
    @CombineObjectBind(UIView())
    var view:UIView
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        
        self.$view.bind(UIView()) { view, list in
            print("bind")
        }
                
        self.view.backgroundColor = .red
        self.$view.needUpdate()
        
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

