import XCTest
@testable import Advance


class EventTests : XCTestCase {
    func testEvent() {
        let payload = 123
        let event = Event<Int>()
        
        let exp1 = expectation(withDescription: "non-keyed")
        let exp2 = expectation(withDescription: "keyed")
        
        event.observe { (p) -> Void in
            XCTAssertEqual(p, payload)
            exp1.fulfill()
        }
        
        event.observe({ (p) -> Void in
            XCTAssertEqual(p, payload)
            exp2.fulfill()
            }, key: "keyed")
        
        event.fire(payload)
        XCTAssertFalse(event.closed)
        
        waitForExpectations(withTimeout: 3.0) { (error) -> Void in
            guard error == nil else { XCTFail(); return }
        }
    }
    
    func testClosing() {
        let payload = 123
        let event = Event<Int>()
        let exp = expectation(withDescription: "exp")
        
        event.observe { (p) -> Void in
            XCTAssertEqual(p, payload)
            exp.fulfill()
        }
        
        event.close(payload)
        XCTAssertTrue(event.closed)
        
        waitForExpectations(withTimeout: 3.0) { (error) -> Void in
            guard error == nil else { XCTFail(); return }
        }
    }
}
