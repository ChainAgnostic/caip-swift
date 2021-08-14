import XCTest
import ChainAgnostic

typealias AccountID = CAIP10.AccountID
typealias Address = AccountID.Address

final class CAIP10Tests: XCTestCase {

    func testAddress() {
        //Parsing Valid Cases
        XCTAssertNoThrow(try Address(parse: "1"))
        XCTAssertNoThrow(try Address(parse: "6d9b0b4b9994e8a6afbd3dc3ed983cd51c755afb27cd1dc7825ef59c134a39f7"))

        //Parsing Invalid Cases
        XCTAssertThrowsError(try Address(parse: ""))
        XCTAssertThrowsError(try Address(parse: ":"))
        XCTAssertThrowsError(try Address(parse: "6d9b0b4b9994e8a6afbd3dc3ed983cd51c755afb27cd1dc7825ef59c134a39f71"))

        let eip155Mainnet = Address("0xab16a96d359ec26a11e2c2b3d8f8b8942d5bfcdb")
        let bip122Mainnet = Address("128Lkh3S7CkDTBZ8W7BbpsN3YYizJMp8p6")

        //ExpressibleByStringLiteral
        XCTAssertEqual(eip155Mainnet, "0xab16a96d359ec26a11e2c2b3d8f8b8942d5bfcdb")

        //LosslessStringConvertible
        XCTAssertEqual(eip155Mainnet.description, "0xab16a96d359ec26a11e2c2b3d8f8b8942d5bfcdb")
        XCTAssertEqual(String(bip122Mainnet), "128Lkh3S7CkDTBZ8W7BbpsN3YYizJMp8p6")

        //Hashable
        XCTAssertEqual(AnyHashable(bip122Mainnet).hashValue, AnyHashable("128Lkh3S7CkDTBZ8W7BbpsN3YYizJMp8p6").hashValue)

        //Codable
        XCTAssertEqual(try! JSON.stringify(eip155Mainnet), "\"0xab16a96d359ec26a11e2c2b3d8f8b8942d5bfcdb\"")
        XCTAssertEqual(try! JSON.parse("{\"addr\": \"128Lkh3S7CkDTBZ8W7BbpsN3YYizJMp8p6\"}"), ["addr": bip122Mainnet])
    }

    func testAccountID() {

        //Parsing Valid Cases
        XCTAssertNoThrow(try AccountID(parse: "ab1:1:1"))
        XCTAssertNoThrow(try AccountID(parse: "chainstd:8c3444cf8970a9e41a706fab93e7a6c4:6d9b0b4b9994e8a6afbd3dc3ed983cd51c755afb27cd1dc7825ef59c134a39f7"))

        //Parsing Invalid Cases
        XCTAssertThrowsError(try AccountID(parse: ""))
        XCTAssertThrowsError(try AccountID(parse: ":"))
        XCTAssertThrowsError(try AccountID(parse: "ab1"))
        XCTAssertThrowsError(try AccountID(parse: "ab1:"))
        XCTAssertThrowsError(try AccountID(parse: "ab1:1"))
        XCTAssertThrowsError(try AccountID(parse: "ab1:1:"))
        XCTAssertThrowsError(try AccountID(parse: "chainstd:8c3444cf8970a9e41a706fab93e7a6c4:6d9b0b4b9994e8a6afbd3dc3ed983cd51c755afb27cd1dc7825ef59c134a39f71"))

        let eip155Mainnet = AccountID("eip155:1", "0xab16a96d359ec26a11e2c2b3d8f8b8942d5bfcdb")
        let bip122Mainnet = AccountID("bip122:000000000019d6689c085ae165831e93", "128Lkh3S7CkDTBZ8W7BbpsN3YYizJMp8p6")

        //ExpressibleByStringLiteral
        XCTAssertEqual(eip155Mainnet, "eip155:1:0xab16a96d359ec26a11e2c2b3d8f8b8942d5bfcdb")

        //LosslessStringConvertible
        XCTAssertEqual(eip155Mainnet.description, "eip155:1:0xab16a96d359ec26a11e2c2b3d8f8b8942d5bfcdb")
        XCTAssertEqual(String(bip122Mainnet), "bip122:000000000019d6689c085ae165831e93:128Lkh3S7CkDTBZ8W7BbpsN3YYizJMp8p6")

        //Hashable
        XCTAssertEqual(AnyHashable(bip122Mainnet).hashValue, AnyHashable("bip122:000000000019d6689c085ae165831e93:128Lkh3S7CkDTBZ8W7BbpsN3YYizJMp8p6").hashValue)

        //Codable
        XCTAssertEqual(try! JSON.stringify(eip155Mainnet), "\"eip155:1:0xab16a96d359ec26a11e2c2b3d8f8b8942d5bfcdb\"")
        XCTAssertEqual(try! JSON.parse("{\"acid\": \"bip122:000000000019d6689c085ae165831e93:128Lkh3S7CkDTBZ8W7BbpsN3YYizJMp8p6\"}"), ["acid": bip122Mainnet])
    }
}
