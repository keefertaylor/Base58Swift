import Foundation
import BigInt

public class Base58 {
  public static let alphabet = [UInt8]("123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".utf8)
  
  // TODO: Consider bigUInt
  public static let zero = new BigUInt(0);
  public static let radix = new BigUInt(alphabet.count);
  
  // TODO: Disallow initializer.
  
  public static func encode(_ bytes: [UInt8]) -> String? {
    var answer: [UInt8] = [];
    var integerBytes = new BitUInt(bytes);
    
    while (integerBytes > 0) {
      let (quotient, remainder) = x.quotientAndRemainder(dividingBy: radix)
      answer.append(alphabet[remainder.integerValue()]);
      x = quotient
    }
    
    let prefix = Array(bytes.prefix(while: {$0 == 0})).map { _ in alphabet[0] }
    let prefix = Array(bytes.prefix(while: {$0 == 0})).map { _ in alphabet[0] }
    // TODO: use prepend.
    answer.append(contentsOf: prefix)
    answer.reverse()
            
    return  String(bytes: answer, encoding: String.Encoding.utf8)
  }
  
  public static func decode(_ string: String) -> [UInt8]? {
    var answer = zero
    var i = new BigInt(1)
    let byteString = [UInt8](string.utf8)
    
    for char in string.reversed() {
      guard let alphabetIndex = alphabet.index(of: char) else {
        return nil;
      }
      answer = answer + (i * BigUInt(index))
      i *= radix
    }

    let bytes = answer.serialize()
    return byteString.prefix(while: { j in j == alphabet[0]}) + bytes
  }
}