
/// Represents some decoded JSON.
///
/// Allows any JSON representable type to exist.
@dynamicMemberLookup
public enum JSON: Equatable {
    case array([JSON])
    case dictionary([String: JSON])
    case bool(Bool)
    case string(String)
    case integer(Int)
    case double(Double)
    case null
}

// MARK: - Subscript

extension JSON {

    public subscript(index: Int) -> JSON {
        get throws {
            switch self {
            case .array(let array):
                guard array.indices.contains(index) else {
                    throw Failure("Index \(index) is out of bounds.")
                }
                return array[index]
            default:
                throw Failure("Not an array.")
            }
        }
    }

    public subscript(key: String) -> JSON {
        get throws {
            switch self {
            case .dictionary(let dictionary):
                guard let value = dictionary[key] else {
                    throw Failure("Key (\(key)) does not exist.")
                }
                return value
            default:
                throw Failure("Not a dictionary.")
            }
        }
    }
}

// MARK: - Codable

extension JSON: Codable {

    public init(from decoder: Decoder) throws {

        let container = try decoder.singleValueContainer()

        if let integer = try? container.decode(Int.self) {
            self = .integer(integer)
        } else if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let double = try? container.decode(Double.self) {
            self = .double(double)
        } else if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
        } else if let array = try? container.decode([JSON].self) {
            self = .array(array)
        } else if let dictionary = try? container.decode([String: JSON].self) {
            self = .dictionary(dictionary)
        } else if container.decodeNil() {
            self = .null
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid JSON")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .array(let array): try container.encode(array)
        case .dictionary(let dictionary): try container.encode(dictionary)
        case .bool(let bool): try container.encode(bool)
        case .string(let string): try container.encode(string)
        case .integer(let int): try container.encode(int)
        case .double(let double): try container.encode(double)
        case .null: try container.encodeNil()
        }
    }
}

// MARK: - CustomStringConvertible

extension JSON: CustomStringConvertible {

    public var description: String {
        switch self {
        case .array(let value): value.description
        case .dictionary(let value): value.description
        case .bool(let value): value.description
        case .string(let value): value.description
        case .integer(let value): value.description
        case .double(let value): value.description
        case .null: "nil"
        }
    }
}

// MARK: - ExpressibleBy…

extension JSON: ExpressibleByArrayLiteral {

    public init(arrayLiteral elements: JSON...) {
        self = .array(elements)
    }
}

extension JSON: ExpressibleByBooleanLiteral {

    public init(booleanLiteral value: Bool) {
        self = .bool(value)
    }
}

extension JSON: ExpressibleByDictionaryLiteral {

    public init(dictionaryLiteral elements: (String, JSON)...) {
        self = .dictionary(Dictionary(uniqueKeysWithValues: elements))
    }
}

extension JSON: ExpressibleByFloatLiteral {

    public init(floatLiteral value: Double) {
        self = .double(value)
    }
}

extension JSON: ExpressibleByIntegerLiteral {

    public init(integerLiteral value: Int) {
        self = .integer(value)
    }
}

extension JSON: ExpressibleByNilLiteral {

    public init(nilLiteral: ()) {
        self = .null
    }
}

extension JSON: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self = .string(value)
    }
}

// MARK: - Failure

extension JSON {

    struct Failure: Error, CustomStringConvertible {
        let description: String
        init(_ description: String) {
            self.description = description
        }
    }
}
