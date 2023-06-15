
extension JSON {

    public subscript(dynamicMember query: Query) -> JSON {
        get throws {
            try self[query]
        }
    }

    public subscript(index: Query) -> JSON {
        get throws {
            switch (self, index.kind) {
            case let (.dictionary(dictionary), .string(key)):
                return try value(in: dictionary, for: key)
            case let (.dictionary(dictionary), .integer(key)):
                return try value(in: dictionary, for: String(key))
            case let (.array(array), .integer(index)):
                return try value(in: array, for: index)
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

    private func value(in array: [JSON], for index: Int) throws -> JSON {
        if array.indices.contains(index) {
            return array[index]
        } else {
            throw Failure("Index \(index) is out of bounds.")
        }
    }

    private func value(in dictionary: [String: JSON], for key: String) throws -> JSON {
        if let value = dictionary[key] {
            return value
        } else {
            throw Failure("Key (\(key)) does not exist.")
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
