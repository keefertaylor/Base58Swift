// Copyright Keefer Taylor, 2019.

import BigInt
import CommonCrypto
import Foundation

/**
 * A static utility class which provides Base58 encoding and decoding functions.
 */
public class Base58 {
  /// Length of checksum appended to Base58Check encoded strings.
  private static let checksumLength = 4

  private static let alphabet = [UInt8]("123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".utf8)
  private static let zero = BigUInt(0)
  private static let radix = BigUInt(alphabet.count)

  /**
   * Encode the given bytes into a Base58Check encoded string.
   */
  public static func base58CheckEncode(_ bytes: [UInt8]) -> String? {
    let checksum = calculateChecksum(bytes)
    let checksummedBytes = bytes + checksum
    let data = Data(checksummedBytes)
    return Base58.base58Encode(data)
  }

  /**
   * Encode the given bytes to a Base58 encoded string.
   */
  public static func base58Encode(_ bytes: Data) -> String? {
    var answer: [UInt8] = []
    var integerBytes = BigUInt(bytes)

    while integerBytes > 0 {
      let (quotient, remainder) = integerBytes.quotientAndRemainder(dividingBy: radix)
      answer.insert(alphabet[Int(remainder)], at: 0)
      integerBytes = quotient
    }

    let prefix = Array(bytes.prefix { $0 == 0 }).map { _ in alphabet[0] }
    answer.insert(contentsOf: prefix, at: 0)

    return String(bytes: answer, encoding: String.Encoding.utf8)
  }

  /**
   * Decode the given base58 encoded string to bytes.
   */
  public static func decode(_ string: String) -> Data? {
    var answer = zero
    var i = BigUInt(1)
    let byteString = [UInt8](string.utf8)

    for char in byteString.reversed() {
      guard let alphabetIndex = alphabet.index(of: char) else {
        return nil
      }
      answer += (i * BigUInt(alphabetIndex))
      i *= radix
    }

    let bytes = answer.serialize()
    return byteString.prefix { i in i == alphabet[0] } + bytes
  }

  /**
   * Calculate a checksum for a given input by hashing twice and then taking the first four bytes.
   */
  private static func calculateChecksum(_ input: [UInt8]) -> [UInt8] {
    let hashedData = sha256(Data(input))
    let doubleHashedData = sha256(hashedData)
    let doubleHashedArray = Array(doubleHashedData)
    return Array(doubleHashedArray.prefix(checksumLength))
  }

  /** Create a sha256 hash of the given data. */
  private static func sha256(_ data: Data) -> Data {
    let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH))!
    CC_SHA256(
      (data as NSData).bytes,
      CC_LONG(data.count),
      res.mutableBytes.assumingMemoryBound(to: UInt8.self)
    )
    return res as Data
  }
}
