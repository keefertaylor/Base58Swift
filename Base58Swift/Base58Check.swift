// Copyright Keefer Taylor, 2019

import Foundation
import CommonCrypto

/**
 * A static utility class which provides Base58Check utility functions.
 */
public class Base58Check {
  // Length of checksum appended to Base58Check encoded strings.
  private static let checksumLength = 4

  /** Append a checksum to the given input string. */
  public static func appendChecksum(_ input: String) -> String? {
    guard let outputBytes = appendChecksum(Array(input.utf8)) else {
      return nil
    }
    return String(bytes: outputBytes, encoding: .utf8)
  }

  /** Append a checksum to the given input byte array. */
  public static func appendChecksum(_ input: [UInt8]) -> [UInt8]? {
    guard let checksum = calculateChecksum(input) else {
      return nil
    }
    return input + checksum
  }

  /**
   * Calculate a checksum for a given input by hashing twice and then taking the first four bytes.
   */
  private static func calculateChecksum(_ input: [UInt8]) -> [UInt8]? {
    guard let hashedData = sha256(Data(input)),
      let doubleHashedData = sha256(hashedData) else {
        return nil
    }
    let doubleHashedArray = Array(doubleHashedData)
    return Array(doubleHashedArray.prefix(checksumLength))
  }

  /** Create a sha256 hash of the given data. */
  private static func sha256(_ data: Data) -> Data? {
    guard let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH)) else {
      return nil
    }
    CC_SHA256(
      (data as NSData).bytes,
      CC_LONG(data.count),
      res.mutableBytes.assumingMemoryBound(to: UInt8.self)
    )
    return res as Data
  }
}
