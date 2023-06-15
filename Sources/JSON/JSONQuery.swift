
extension JSON {

    public subscript(dynamicMember query: Query) -> JSON {
        get throws {
            switch (self, query.kind) {
            case (.dictionary, .string(let string)):
                return try self[string]
            case (.dictionary, .integer(let integer)):
                return try self[String(integer)]
            case (.array, .integer(let integer)):
                return try self[integer]
            case (.array, .string(let string)):
                throw Failure("Cannot query an array with a string (\(string)).")
            case (.bool, _):
                throw Failure("Cannot query a boolean value.")
            case (.string, _):
                throw Failure("Cannot query a string value.")
            case (.integer, _):
                throw Failure("Cannot query an integer value.")
            case (.double, _):
                throw Failure("Cannot query a double value.")
            case (.null, _):
                throw Failure("Cannot query a nil value.")
            }
        }
    }
}

extension JSON {

    public struct Query {
        fileprivate let kind: Kind
    }
}

extension JSON.Query {

    fileprivate enum Kind {
        case integer(Int)
        case string(String)
    }

    private init(_ integer: Int) {
        self.init(kind: .integer(integer))
    }

    private init(_ string: String) {
        if let integer = Int(string) {
            self.init(integer)
        } else {
            self.init(kind: .string(string))
        }
    }
}

extension JSON.Query: ExpressibleByStringLiteral {

    public init(stringLiteral string: String) {
        self.init(string)
    }
}

extension JSON.Query: ExpressibleByIntegerLiteral {

    public init(integerLiteral integer: Int) {
        self.init(integer)
    }
}
