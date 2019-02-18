// Copyright Keefer Taylor, 2019

import CommonCrypto
import Foundation
//
///**
// * A static utility class which provides Base58Check utility functions.
// */
//public class Base58Check {
//  // Length of checksum appended to Base58Check encoded strings.
//  private static let checksumLength = 4
//
//  /** Append a checksum to the given input string. */
//  public static func appendChecksum(_ input: String) -> String? {
//    let outputBytes = appendChecksum(Array(input.utf8))
//    let data = Data(outputBytes)
//    return Base58.encode(data)
//  }
//
//  /** Append a checksum to the given input byte array. */
//  public static func appendChecksum(_ input: [UInt8]) -> [UInt8] {
//    let checksum = calculateChecksum(input)
//    return input + checksum
//  }
//}
