// Copyright Keefer Taylor, 2019.

import Base58Swift
import XCTest

class Base58SwiftTests: XCTestCase {
  // Tuples of arbitrary strings that are mapped to valid Base58 encodings.
  private let validStringDecodedToEncodedTuples = [
    ("", ""),
    (" ", "Z"),
    ("-", "n"),
    ("0", "q"),
    ("1", "r"),
    ("-1", "4SU"),
    ("11", "4k8"),
    ("abc", "ZiCa"),
    ("1234598760", "3mJr7AoUXx2Wqd"),
    ("abcdefghijklmnopqrstuvwxyz", "3yxU3u1igY8WkgtjK92fbJQCd4BZiiT1v25f"),
    ("00000000000000000000000000000000000000000000000000000000000000",
     "3sN2THZeE9Eh9eYrwkvZqNstbHGvrxSAM7gXUXvyFQP8XvQLUqNCS27icwUeDT7ckHm4FUHM2mTVh1vbLmk7y")
  ]

  // Tuples of invalid strings.
  private let invalidStrings = [
    "0",
    "O",
    "I",
    "l",
    "3mJr0",
    "O3yxU",
    "3sNI",
    "4kl8",
    "0OIl",
    "!@#$%^&*()-_=+~`"
  ]

  public func testEncodingForValidStrings() {
    for (decoded, encoded) in validStringDecodedToEncodedTuples {
      let bytes = [UInt8](decoded.utf8)
      guard let result = Base58.encode(Data(bytes)) else {
        XCTFail()
        return
      }
      XCTAssertEqual(result, encoded)
    }
  }

  public func testDecodingForValidStrings() {
    for (decoded, encoded) in validStringDecodedToEncodedTuples {
      guard let bytes = Base58.decode(encoded) else {
        XCTFail()
        return
      }
      let result = String(bytes: bytes, encoding: String.Encoding.utf8)
      XCTAssertEqual(result, decoded)
    }
  }

  public func testDecodingForInvalidStrings() {
    for invalidString in invalidStrings {
      let result = Base58.decode(invalidString)
      XCTAssertNil(result)
    }
  }
}
