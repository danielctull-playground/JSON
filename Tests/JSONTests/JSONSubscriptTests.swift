
import JSON
import XCTest

final class JSONSubscriptTests: XCTestCase {

    func testArray() {
        let json = JSON.array([
            .string("string"),
            .integer(4),
            .double(19.5),
            .bool(true),
            .bool(false),
            .null,
            .array([.integer(1), .integer(2), .integer(3)]),
            .dictionary(["key": .string("value")])
        ])

        XCTAssertEqual(json[2], .double(19.5))
        XCTAssertEqual(json[5], .null)
        XCTAssertEqual(json[7]["key"], .string("value"))
    }

    func testDictionary() {
        let json = JSON.dictionary([
            "string": .string("string"),
            "integer": .integer(4),
            "true": .bool(true),
            "false": .bool(false),
            "null": .null,
            "array": .array([.integer(1), .integer(2), .integer(3)]),
            "dictionary": .dictionary(["key": .string("value")])
        ])

        XCTAssertEqual(json["string"], .string("string"))
        XCTAssertEqual(json["true"], .bool(true))
        XCTAssertEqual(json["array"][1], .integer(2))
    }
}
