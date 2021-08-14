/// https://github.com/ChainAgnostic/CAIPs/blob/master/CAIPs/caip-10.md
public enum CAIP10 {

    public enum FormatError: Swift.Error {
        case invalidAddress
        case invalidAccountID
    }

    public struct AccountID {

        public struct Address {

            fileprivate let rawValue: String

            public init(parse rawValue: String) throws {
                guard (1...64).contains(rawValue.count) else {
                    throw FormatError.invalidAddress
                }
                guard rawValue.allSatisfy({ $0.isAsciiLetter || $0.isAsciiDigit }) else {
                    throw FormatError.invalidAddress
                }
                self.rawValue = rawValue
            }
        }

        public typealias ChainID = CAIP2.ChainID

        public var chainID: ChainID

        public var address: Address

        fileprivate var rawValue: String {
            return "\(chainID):\(address)"
        }

        public init(_ chainID: ChainID, _ address: Address) {
            self.chainID = chainID
            self.address = address
        }

        public init(parse rawValue: String) throws {
            var components = rawValue.split(separator: ":")
            guard components.count >= 2 else {
                throw FormatError.invalidAccountID
            }

            let address = String(components.removeLast())
            let chainID = components.joined(separator: ":")

            self.address = try Address(parse: address)
            self.chainID = try ChainID(parse: chainID)
        }
    }
}

//MARK:- LosslessStringConvertible

extension CAIP10.AccountID: LosslessStringConvertible {

    public var description: String {
        return rawValue
    }

    public init?(_ description: String) {
        try? self.init(parse: description)
    }
}

extension CAIP10.AccountID.Address: LosslessStringConvertible {

    public var description: String {
        return rawValue
    }

    public init?(_ description: String) {
        try? self.init(parse: description)
    }
}

//MARK:- ExpressibleByStringLiteral

extension CAIP10.AccountID: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        try! self.init(parse: value)
    }
}

extension CAIP10.AccountID.Address: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        try! self.init(parse: value)
    }
}

//MARK:- Hashable

extension CAIP10.AccountID: Hashable {

    public func hash(into hasher: inout Hasher) {
        rawValue.hash(into: &hasher)
    }
}

extension CAIP10.AccountID.Address: Hashable {

    public func hash(into hasher: inout Hasher) {
        rawValue.hash(into: &hasher)
    }
}

//MARK:- Codable

extension CAIP10.AccountID: Codable {

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

extension CAIP10.AccountID.Address: Codable {

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
