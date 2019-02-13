// Copyright Keefer Taylor, 2019.

import BigInt
import Foundation

/**
 * A static utility class which provides Base58 encoding and decoding functions.
 */
public class Base58 {
  private static let alphabet = [UInt8]("123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".utf8)
  private static let zero = BigUInt(0)
  private static let radix = BigUInt(alphabet.count)

  /**
   * Encode the given bytes to a Base58 encoded string.
   */
  public static func encode(_ bytes: Data) -> String? {
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
}
