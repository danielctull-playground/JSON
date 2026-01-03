import JSON
import XCTest

final class SubscriptTests: XCTestCase {

  func testIndex() throws {
    let array = JSON.array([
      .string("string"),
      .integer(4),
      .double(19.5),
      .bool(true),
      .bool(false),
      .null,
      .array([.integer(1), .integer(2), .integer(3)]),
      .dictionary(["key": .string("value")]),
    ])

    XCTAssertEqual(try array[0], .string("string"))
    XCTAssertEqual(try array[1], .integer(4))
    XCTAssertEqual(try array[2], .double(19.5))
    XCTAssertEqual(try array[3], .bool(true))
    XCTAssertEqual(try array[4], .bool(false))
    XCTAssertEqual(try array[5], .null)
    XCTAssertEqual(try array[6][0], .integer(1))
    XCTAssertEqual(try array[6][1], .integer(2))
    XCTAssertEqual(try array[6][2], .integer(3))
    XCTAssertEqual(try array[7]["key"], .string("value"))
    XCTAssertThrowsError(try array[8])
    XCTAssertThrowsError(try JSON.null[8])
  }

  func testKey() throws {
    let dictionary = JSON.dictionary([
      "string": .string("string"),
      "integer": .integer(4),
      "true": .bool(true),
      "false": .bool(false),
      "null": .null,
      "array": .array([.integer(1), .integer(2), .integer(3)]),
      "dictionary": .dictionary(["key": .string("value")]),
    ])

    XCTAssertEqual(try dictionary["string"], .string("string"))
    XCTAssertEqual(try dictionary["integer"], .integer(4))
    XCTAssertEqual(try dictionary["true"], .bool(true))
    XCTAssertEqual(try dictionary["false"], .bool(false))
    XCTAssertEqual(try dictionary["null"], .null)
    XCTAssertEqual(try dictionary["array"][0], .integer(1))
    XCTAssertEqual(try dictionary["array"][1], .integer(2))
    XCTAssertEqual(try dictionary["array"][2], .integer(3))
    XCTAssertEqual(try dictionary["dictionary"]["key"], .string("value"))
    XCTAssertThrowsError(try dictionary["not here"])
    XCTAssertThrowsError(try JSON.null["not here"])
  }
}
