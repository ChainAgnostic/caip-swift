import Foundation

extension JSONDecoder {

    internal func decode<T: Decodable>(_ type: T.Type, from string: String) throws -> T {
        guard let data = string.data(using: .default) else {
            throw String.Encoding.Error.decoding(string, encoding: .default)
        }
        return try self.decode(type, from: data)
    }
}

extension JSONEncoder {

    internal func encode<T: Encodable>(_ value: T) throws -> String {
        let data: Data = try self.encode(value)
        guard let string = String(data: data, encoding: .default) else {
            throw String.Encoding.Error.encoding(data, encoding: .default)
        }
        return string
    }
}
