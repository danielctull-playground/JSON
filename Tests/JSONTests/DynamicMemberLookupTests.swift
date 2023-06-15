
import JSON
import XCTest

final class DynamicMemberLookupTests: XCTestCase {

    func testArray() throws {

        let array: JSON = [
            [
                "value 0 0",
                "value 0 1",
            ],
            [
                "value 1 0",
                "value 1 1",
            ],
            [
                "value 2 0",
                "value 2 1",
            ],
        ]

        XCTAssertEqual(try array.0.0, "value 0 0")
        XCTAssertEqual(try array.0.1, "value 0 1")
        XCTAssertEqual(try array.1.0, "value 1 0")
        XCTAssertEqual(try array.1.1, "value 1 1")
        XCTAssertEqual(try array.2.0, "value 2 0")
        XCTAssertEqual(try array.2.1, "value 2 1")
        XCTAssertThrowsError(try array.3)
        XCTAssertThrowsError(try array.a)
    }

    func testBool() {
        XCTAssertThrowsError(try JSON.bool(true).a)
        XCTAssertThrowsError(try JSON.bool(true).0)
    }

    func testDictionary() throws {

        let dictionary: JSON = [
            "1": [
                "a": "value 1 a",
                "b": "value 1 b"
            ],
            "2": [
                "a": "value 2 a",
                "b": "value 2 b"
            ],
            "3": [
                "a": "value 3 a",
                "b": "value 3 b"
            ],
        ]

        XCTAssertEqual(try dictionary.1.a, "value 1 a")
        XCTAssertEqual(try dictionary.1.b, "value 1 b")
        XCTAssertEqual(try dictionary.2.a, "value 2 a")
        XCTAssertEqual(try dictionary.2.b, "value 2 b")
        XCTAssertEqual(try dictionary.3.a, "value 3 a")
        XCTAssertEqual(try dictionary.3.b, "value 3 b")
        XCTAssertThrowsError(try dictionary.4)
    }

    func testDouble() {
        XCTAssertThrowsError(try JSON.double(1.2).a)
        XCTAssertThrowsError(try JSON.double(1.2).0)
    }

    func testInteger() {
        XCTAssertThrowsError(try JSON.integer(1).a)
        XCTAssertThrowsError(try JSON.integer(1).0)
    }

    func testNull() {
        XCTAssertThrowsError(try JSON.null.a)
        XCTAssertThrowsError(try JSON.null.0)
    }

    func testString() {
        XCTAssertThrowsError(try JSON.string("string").a)
        XCTAssertThrowsError(try JSON.string("string").0)
    }
}
