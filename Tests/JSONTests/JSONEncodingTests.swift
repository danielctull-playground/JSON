
import JSON
import XCTest

final class JSONEncodingTests: XCTestCase {

    func testArray() throws {
        try Assert {
            .array([
                .string("string"),
                .integer(4),
                .bool(true),
                .bool(false),
                .null,
                .array([.integer(1), .integer(2), .integer(3)]),
                .dictionary(["key": .string("value")])
            ])
        } encodesTo: {
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
        }
    }

    func testBool() throws {
        try Assert { .bool(true) } encodesTo: { "true" }
        try Assert { .bool(false) } encodesTo: { "false" }
    }

    func testDictionary() throws {
        try Assert {
            .dictionary([
                "string": .string("string"),
                "integer": .integer(4),
                "true": .bool(true),
                "false": .bool(false),
                "null": .null,
                "array": .array([.integer(1), .integer(2), .integer(3)]),
                "dictionary": .dictionary(["key": .string("value")])
            ])
        } encodesTo: {
            """
            {
                "array": [1, 2, 3],
                "dictionary": { "key": "value" },
                "false": false,
                "integer": 4,
                "null": null,
                "string": "string",
                "true": true
            }
            """
        }
    }

    func testDouble() throws {
        try Assert { .double(19.5) } encodesTo: { "19.5" }
    }

    func testInteger() throws {
        try Assert { .integer(19) } encodesTo: { "19" }
    }

    func testNull() throws {
        try Assert { .null } encodesTo: { "null" }
    }

    func testString() throws {
        try Assert { .string("string") } encodesTo: { "\"string\"" }
    }
}

fileprivate func Assert(
    json: () -> JSON,
    encodesTo expected: () -> String,
    file: StaticString = #filePath,
    line: UInt = #line
) throws {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .sortedKeys
    let data = try encoder.encode(json())

    func normalize(_ string: String) -> String {
        string
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "\n", with: "")
    }

    let string = try XCTUnwrap(String(data: data, encoding: .utf8))
    XCTAssertEqual(normalize(string), normalize(expected()), file: file, line: line)
}
