import Foundation

internal enum JSON {

    private static let decoder = JSONDecoder()
    private static let encoder = JSONEncoder()

    internal static func parse<T: Decodable>(_ value: String) throws -> T {
        try decoder.decode(T.self, from: value)
    }

    internal static func stringify<T: Encodable>(_ value: T) throws -> String {
        try encoder.encode(value)
    }
}
