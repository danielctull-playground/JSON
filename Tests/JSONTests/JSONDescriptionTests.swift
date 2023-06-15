
import JSON
import XCTest

final class JSONDescriptionTests: XCTestCase {

    func testArray() {
        Assert {
            .array([
                .integer(1),
                .integer(2),
                .integer(3)
            ])
        } description: {
            "[1, 2, 3]"
        }
    }

    func testBool() {
        Assert { .bool(true) } description: { "true" }
        Assert { .bool(false) } description: { "false" }
    }

    func testDictionary() throws {
        Assert {
            .dictionary([
                "string": .string("string"),
            ])
        } description: {
            """
            ["string": string]
            """
        }
    }

    func testDouble() {
        Assert { .double(14.2) } description: { "14.2" }
    }

    func testInteger() {
        Assert { .integer(1) } description: { "1" }
    }

    func testNull() {
        Assert { .null } description: { "nil" }
    }

    func testString() {
        Assert { .string("string") } description: { "string" }
    }
}

fileprivate func Assert(
    _ json: () -> JSON,
    description expected: () -> String,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTAssertEqual(json().description, expected(), file: file, line: line)
}
