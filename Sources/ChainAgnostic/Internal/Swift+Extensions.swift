extension Character {

    @inline(__always)
    internal var isAsciiDigit: Bool {
        return self.isASCII && self.isNumber
    }

    @inline(__always)
    internal var isAsciiLetter: Bool {
        return self.isASCII && self.isLetter
    }

    @inline(__always)
    internal var isLowercaseAsciiLetter: Bool {
        return self.isAsciiLetter && self.isLowercase
    }

    @inline(__always)
    internal var isUppercaseAsciiLetter: Bool {
        return self.isAsciiLetter && self.isUppercase
    }
}

extension DecodingError {

    @inline(__always)
    internal static func dataCorrupted(codingPath: [CodingKey], underlyingError: Swift.Error) -> Self {
        let context = DecodingError.Context(
            codingPath: codingPath,
            debugDescription: "Invalid data",
            underlyingError: underlyingError
        )
        return DecodingError.dataCorrupted(context)
    }
}
