
import JSON
import XCTest

final class Demo: XCTestCase {
    
    func test() throws {
        let json = JSON.dictionary([
            "string" : "Some string",
            "array" : [
                "An array of things",
                1,
                2.4,
                true,
                false,
                nil,
                "because json!",
            ],
            "integer": 1,
            "double": 19.5,
            "true": true,
            "false": false,
            "nil": nil,
        ])

        XCTAssertEqual(try json.string, "Some string")
        XCTAssertEqual(try json.array.0, "An array of things")
        XCTAssertEqual(try json.array.1, 1)
        XCTAssertEqual(try json.array.2, 2.4)
        XCTAssertEqual(try json.array.3, true)
        XCTAssertEqual(try json.array.4, false)
        XCTAssertEqual(try json.array.5, nil)
        XCTAssertEqual(try json.array.6, "because json!")
        XCTAssertEqual(try json.integer, 1)
        XCTAssertEqual(try json.double, 19.5)
        XCTAssertEqual(try json.true, true)
        XCTAssertEqual(try json.false, false)
        XCTAssertEqual(try json.nil, nil)
    }
}
