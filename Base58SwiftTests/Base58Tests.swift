// Copyright Keefer Taylor, 2019.

import Base58Swift
import XCTest

class Base58SwiftTests: XCTestCase {
  /// Tuples of arbitrary strings that are mapped to valid Base58 encodings.
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

  /// Tuples of invalid strings.
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

  public func testBase58EncodingForValidStrings() {
    for (decoded, encoded) in validStringDecodedToEncodedTuples {
      let bytes = [UInt8](decoded.utf8)
      let result = Base58.base58Encode(bytes)
      XCTAssertEqual(result, encoded)
    }
  }

  public func testBase58DecodingForValidStrings() {
    for (decoded, encoded) in validStringDecodedToEncodedTuples {
      guard let bytes = Base58.base58Decode(encoded) else {
        XCTFail()
        return
      }
      let result = String(bytes: bytes, encoding: String.Encoding.utf8)
      XCTAssertEqual(result, decoded)
    }
  }

  public func testBase58DecodingForInvalidStrings() {
    for invalidString in invalidStrings {
      let result = Base58.base58Decode(invalidString)
      XCTAssertNil(result)
    }
  }

  public func testBase58CheckEncoding() {
    let inputData: [UInt8] = [
      6, 161, 159, 136, 34, 110, 33, 238, 14, 79, 14, 218, 133, 13, 109, 40, 194, 236, 153, 44, 61, 157, 254
    ]
    let expectedOutput = "tz1Y3qqTg9HdrzZGbEjiCPmwuZ7fWVxpPtRw"
    let actualOutput = Base58.base58CheckEncode(inputData)
    XCTAssertEqual(actualOutput, expectedOutput)
  }

  public func testBase58CheckDecoding() {
    let inputString = "tz1Y3qqTg9HdrzZGbEjiCPmwuZ7fWVxpPtRw"
    let expectedOutputData: [UInt8] = [
      6, 161, 159, 136, 34, 110, 33, 238, 14, 79, 14, 218, 133, 13, 109, 40, 194, 236, 153, 44, 61, 157, 254
    ]

    guard let actualOutput = Base58.base58CheckDecode(inputString) else {
      XCTFail()
      return
    }
    XCTAssertEqual(actualOutput, expectedOutputData)
  }

  public func testBase58CheckDecodingLeadingOne() {
    let inputString = "1CdPoF9cvw3YEiuRCHxdsGpvb5tSUYBBo"
    let expectedOutputData: [UInt8] = [
      0, 2, 50, 244, 121, 42, 5, 10, 13, 224, 245, 201, 20, 55, 55, 148, 92, 255, 84, 36, 4
    ]
    guard let actualOutput = Base58.base58CheckDecode(inputString) else {
      XCTFail()
      return
    }
    XCTAssertEqual(actualOutput, expectedOutputData)
    
  }
    
  public func testDecodeLeadingOnes() {
    let inputString = "11111111111111111111111111111111"
    let expectedOutputData: [UInt8] = [
      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    ]
    
    guard let actualOutput = Base58.base58Decode(inputString) else {
      XCTFail()
      return
    }
    XCTAssertEqual(actualOutput, expectedOutputData)
  }

  public func testBase58CheckDecodingWithInvalidCharacters() {
    XCTAssertNil(Base58.base58CheckDecode("0oO1lL"))
  }

  public func testBase58CheckDecodingWithInvalidChecksum() {
    XCTAssertNil(Base58.base58CheckDecode("tz1Y3qqTg9HdrzZGbEjiCPmwuZ7fWVxpPtrW"))
  }
}
