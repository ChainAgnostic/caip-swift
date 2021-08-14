import XCTest
import ChainAgnostic

typealias ChainID = CAIP2.ChainID
typealias Namespace = ChainID.Namespace
typealias Reference = ChainID.Reference

final class CAIP2Tests: XCTestCase {

    func testNamespace() {
        //Parsing Valid Cases
        XCTAssertNoThrow(try Namespace(parse: "ab1"))
        XCTAssertNoThrow(try Namespace(parse: "chainstd"))

        //Parsing Invalid Cases
        XCTAssertThrowsError(try Namespace(parse: ""))
        XCTAssertThrowsError(try Namespace(parse: "a"))
        XCTAssertThrowsError(try Namespace(parse: "a1"))
        XCTAssertThrowsError(try Namespace(parse: ":"))
        XCTAssertThrowsError(try Namespace(parse: "chainstd1"))

        let eip155 = Namespace("eip155")
        let bip122 = Namespace("bip122")

        //ExpressibleByStringLiteral
        XCTAssertEqual(eip155, "eip155")

        //LosslessStringConvertible
        XCTAssertEqual(eip155.description, "eip155")
        XCTAssertEqual(String(bip122), "bip122")

        //Hashable
        XCTAssertEqual(AnyHashable(eip155).hashValue, AnyHashable("eip155").hashValue)

        //Codable
        XCTAssertEqual(try! JSON.stringify(eip155), "\"eip155\"")
        XCTAssertEqual(try! JSON.parse("{\"ns\": \"bip122\"}"), ["ns": bip122])
    }

    func testReference() {
        //Parsing Valid Cases
        XCTAssertNoThrow(try Reference(parse: "1"))
        XCTAssertNoThrow(try Reference(parse: "8c3444cf8970a9e41a706fab93e7a6c4"))

        //Parsing Invalid Cases
        XCTAssertThrowsError(try Reference(parse: ""))
        XCTAssertThrowsError(try Reference(parse: ":"))
        XCTAssertThrowsError(try Reference(parse: "8c3444cf8970a9e41a706fab93e7a6c41"))

        let eip155Mainnet = Reference("1")
        let bip122Mainnet = Reference("000000000019d6689c085ae165831e93")

        //ExpressibleByStringLiteral
        XCTAssertEqual(eip155Mainnet, "1")

        //LosslessStringConvertible
        XCTAssertEqual(eip155Mainnet.description, "1")
        XCTAssertEqual(String(bip122Mainnet), "000000000019d6689c085ae165831e93")

        //Hashable
        XCTAssertEqual(AnyHashable(bip122Mainnet).hashValue, AnyHashable("000000000019d6689c085ae165831e93").hashValue)

        //Codable
        XCTAssertEqual(try! JSON.stringify(eip155Mainnet), "\"1\"")
        XCTAssertEqual(try! JSON.parse("{\"ns\": \"000000000019d6689c085ae165831e93\"}"), ["ns": bip122Mainnet])
    }

    func testChainID() {
        //Parsing Valid Cases
        XCTAssertNoThrow(try ChainID(parse: "ab1:1"))
        XCTAssertNoThrow(try ChainID(parse: "chainstd:8c3444cf8970a9e41a706fab93e7a6c4"))

        //Parsing Invalid Cases
        XCTAssertThrowsError(try ChainID(parse: ""))
        XCTAssertThrowsError(try ChainID(parse: ":"))
        XCTAssertThrowsError(try ChainID(parse: "ab1:"))
        XCTAssertThrowsError(try ChainID(parse: ":1"))
        XCTAssertThrowsError(try ChainID(parse: "chainstd8c3444cf8970a9e41a706fab93e7a6c41"))
        XCTAssertThrowsError(try ChainID(parse: "chainstd1:8c3444cf8970a9e41a706fab93e7a6c4"))
        XCTAssertThrowsError(try ChainID(parse: "chainstd:8c3444cf8970a9e41a706fab93e7a6c41"))

        let eip155Mainnet = ChainID(Namespace("eip155"), Reference("1"))
        let bip122Mainnet = ChainID("bip122", "000000000019d6689c085ae165831e93")

        //ExpressibleByStringLiteral
        XCTAssertEqual(eip155Mainnet, "eip155:1")

        //LosslessStringConvertible
        XCTAssertEqual(eip155Mainnet.description, "eip155:1")
        XCTAssertEqual(String(bip122Mainnet), "bip122:000000000019d6689c085ae165831e93")

        //Hashable
        XCTAssertEqual(AnyHashable(bip122Mainnet).hashValue, AnyHashable("bip122:000000000019d6689c085ae165831e93").hashValue)

        //Codable
        XCTAssertEqual(try! JSON.stringify(eip155Mainnet), "\"eip155:1\"")
        XCTAssertEqual(try! JSON.parse("{\"chid\": \"bip122:000000000019d6689c085ae165831e93\"}"), ["chid": bip122Mainnet])
    }
}
