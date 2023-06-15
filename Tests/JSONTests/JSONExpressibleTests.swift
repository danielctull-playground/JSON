
import JSON
import XCTest

final class JSONExpressibleTests: XCTestCase {

    func testExpressibleByArrayLiteral() {
        Assert {
            [
                "string",
                4,
                19.5,
                true,
                false,
                nil,
                [1, 2, 3],
                ["key": "value"],
            ]
        } is: {
            .array([
                .string("string"),
                .integer(4),
                .double(19.5),
                .bool(true),
                .bool(false),
                .null,
                .array([.integer(1), .integer(2), .integer(3)]),
                .dictionary(["key": .string("value")])
            ])
        }
    }

    func testExpressibleByBooleanLiteral() {
        Assert { true } is: { .bool(true) }
        Assert { false } is: { .bool(false) }
    }

    func testExpressibleByDictionaryLiteral() {
        Assert {
            [
                "string": "string",
                "integer": 4,
                "double": 19.5,
                "true": true,
                "false": false,
                "null": nil,
                "array": [1,2,3],
                "dictionary": ["key": "value"],
            ]
        } is: {
            .dictionary([
                "string": .string("string"),
                "integer": .integer(4),
                "double": .double(19.5),
                "true": .bool(true),
                "false": .bool(false),
                "null": .null,
                "array": .array([.integer(1), .integer(2), .integer(3)]),
                "dictionary": .dictionary(["key": .string("value")])
            ])
        }
    }

    func testExpressibleByFloatLiteral() {
        Assert { 19.5 } is: { .double(19.5) }
    }

    func testExpressibleByIntegerLiteral() {
        Assert { 19 } is: { .integer(19) }
    }

    func testExpressibleByNilLiteral() {
        Assert { nil } is: { .null }
    }

    func testExpressibleByStringLiteral() {
        Assert { "string" } is: { .string("string") }
    }
}

fileprivate func Assert(
    _ json: () -> JSON,
    is expected: () -> JSON,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTAssertEqual(json(), expected(), file: file, line: line)
}
