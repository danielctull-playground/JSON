
import JSON
import XCTest

final class JSONDecodingTests: XCTestCase {

    func testArray() throws {
        try Assert {
            """
            [
                "string",
                4,
                true,
                false,
                null,
                [1, 2, 3],
                { "key": "value" }
            ]
            """
        } decodesTo: {
            .array([
                .string("string"),
                .integer(4),
                .bool(true),
                .bool(false),
                .null,
                .array([.integer(1), .integer(2), .integer(3)]),
                .dictionary(["key": .string("value")])
            ])
        }
    }

    func testBool() throws {
        try Assert { "true" } decodesTo: { .bool(true) }
        try Assert { "false" } decodesTo: { .bool(false) }
    }

    func testDictionary() throws {
        try Assert {
            """
            {
                "string": "string",
                "integer": 4,
                "true": true,
                "false": false,
                "null": null,
                "array": [1, 2, 3],
                "dictionary": { "key": "value" }
            }
            """
        } decodesTo: {
            .dictionary([
                "string": .string("string"),
                "integer": .integer(4),
                "true": .bool(true),
                "false": .bool(false),
                "null": .null,
                "array": .array([.integer(1), .integer(2), .integer(3)]),
                "dictionary": .dictionary(["key": .string("value")])
            ])
        }
    }

    func testDouble() throws {
        try Assert { "19.19" } decodesTo: { .double(19.19) }
    }

    func testInteger() throws {
        try Assert { "19" } decodesTo: { .integer(19) }
    }

    func testNull() throws {
        try Assert { "null" } decodesTo: { .null }
    }

    func testString() throws {
        try Assert { "\"string\"" } decodesTo: { .string("string") }
    }
}

fileprivate func Assert(
    json string: () -> String,
    decodesTo expected: () -> JSON,
    file: StaticString = #filePath,
    line: UInt = #line
) throws {
    let data = try XCTUnwrap(string().data(using: .utf8))
    let json = try JSONDecoder().decode(JSON.self, from: data)
    XCTAssertEqual(json, expected(), file: file, line: line)
}
