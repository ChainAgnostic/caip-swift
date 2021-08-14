import Foundation

extension String.Encoding {

    internal enum Error: Swift.Error {
        case encoding(_ data: Data, encoding: String.Encoding)
        case decoding(_ string: String, encoding: String.Encoding)
    }

    internal static var `default`: Self = .utf8
}
