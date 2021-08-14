/// https://github.com/ChainAgnostic/CAIPs/blob/master/CAIPs/caip-2.md
public enum CAIP2 {

    public enum FormatError: Swift.Error {
        case invalidNamespace
        case invalidReference
        case invalidChainID
    }

    public struct ChainID {

        public struct Namespace {

            fileprivate let rawValue: String

            public init(parse rawValue: String) throws {
                guard (3...8).contains(rawValue.count) else {
                    throw FormatError.invalidNamespace
                }
                guard rawValue.allSatisfy({ $0.isLowercaseAsciiLetter || $0.isAsciiDigit }) else {
                    throw FormatError.invalidNamespace
                }
                self.rawValue = rawValue
            }
        }

        public struct Reference {

            fileprivate let rawValue: String

            public init(parse rawValue: String) throws {
                guard (1...32).contains(rawValue.count) else {
                    throw FormatError.invalidReference
                }
                guard rawValue.allSatisfy({ $0.isAsciiLetter || $0.isAsciiDigit }) else {
                    throw FormatError.invalidReference
                }
                self.rawValue = rawValue
            }
        }

        public var namespace: Namespace

        public var reference: Reference

        fileprivate var rawValue: String {
            return "\(namespace):\(reference)"
        }

        public init(_ namespace: Namespace, _ reference: Reference) {
            self.namespace = namespace
            self.reference = reference
        }

        public init(parse rawValue: String) throws {
            let components = rawValue.split(separator: ":")
            guard components.count == 2 else {
                throw FormatError.invalidChainID
            }
            self.namespace = try Namespace(parse: String(components[0]))
            self.reference = try Reference(parse: String(components[1]))
        }
    }
}

//MARK:- LosslessStringConvertible

extension CAIP2.ChainID: LosslessStringConvertible {

    public var description: String {
        return rawValue
    }

    public init?(_ description: String) {
        try? self.init(parse: description)
    }
}

extension CAIP2.ChainID.Namespace: LosslessStringConvertible {

    public var description: String {
        return rawValue
    }

    public init?(_ description: String) {
        try? self.init(parse: description)
    }
}

extension CAIP2.ChainID.Reference: LosslessStringConvertible {

    public var description: String {
        return rawValue
    }

    public init?(_ description: String) {
        try? self.init(parse: description)
    }
}

//MARK:- ExpressibleByStringLiteral

extension CAIP2.ChainID: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        try! self.init(parse: value)
    }
}

extension CAIP2.ChainID.Namespace: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        try! self.init(parse: value)
    }
}

extension CAIP2.ChainID.Reference: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        try! self.init(parse: value)
    }
}

//MARK:- Hashable

extension CAIP2.ChainID: Hashable {

    public func hash(into hasher: inout Hasher) {
        rawValue.hash(into: &hasher)
    }
}

extension CAIP2.ChainID.Namespace: Hashable {

    public func hash(into hasher: inout Hasher) {
        rawValue.hash(into: &hasher)
    }
}

extension CAIP2.ChainID.Reference: Hashable {

    public func hash(into hasher: inout Hasher) {
        rawValue.hash(into: &hasher)
    }
}

//MARK:- Codable

extension CAIP2.ChainID: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        do {
            try self.init(parse: rawValue)
        } catch let error {
            throw DecodingError.dataCorrupted(codingPath: decoder.codingPath, underlyingError: error)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }
}

extension CAIP2.ChainID.Namespace: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        do {
            try self.init(parse: rawValue)
        } catch let error {
            throw DecodingError.dataCorrupted(codingPath: decoder.codingPath, underlyingError: error)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }
}

extension CAIP2.ChainID.Reference: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        do {
            try self.init(parse: rawValue)
        } catch let error {
            throw DecodingError.dataCorrupted(codingPath: decoder.codingPath, underlyingError: error)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }
}
