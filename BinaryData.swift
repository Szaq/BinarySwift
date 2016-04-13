//
//  BinaryData.swift
//  BinaryData
//
//  Created by Łukasz Kwoska on 08.12.2015.
//  Copyright © 2015 Macoscope Sp. z o.o. All rights reserved.
//

import Foundation

/**
 Structure for fast/immutable parsing of binary file.
 */
public struct BinaryData : ArrayLiteralConvertible {
  public typealias Element = UInt8
  ///Underlying data for this object.
  public let data: [UInt8]
  ///Is data in big-endian byte order?
  public let bigEndian: Bool
  
  // MARK: - Initializers
  
  /**
   Initialize with array literal
   
   You may initialize `BinaryData` with array literal like so:
   ```
   let data:BinaryData = [0xf, 0x00, 0x1, 0xa]
   ```
   
   - parameter data: `NSData` to parse
   - parameter bigEndian: Is data in big-endian or little-endian order?
   
   - returns: Initialized object
   
   - remark: Data is copied.
   */
  public init(arrayLiteral elements: Element...) {
    data = elements
    bigEndian = true
  }
  
  /**
   Initialize with array
   
   - parameter data: `Array` containing data to parse
   - parameter bigEndian: Is data in big-endian or little-endian order?
   
   - returns: Initialized object
   
   - remark: Data is copied.
   */
  
  public init(data: [UInt8], bigEndian: Bool = true) {
    self.data = data
    self.bigEndian = bigEndian
  }
  
  /**
   Initialize with `NSData`
   
   - parameter data: `NSData` to parse
   - parameter bigEndian: Is data in big-endian or little-endian order?
   
   - returns: Initialized object
   
   - remark: Data is copied.
   */
  public init(data:NSData, bigEndian: Bool = true) {
    
    self.bigEndian = bigEndian
    
    var mutableData = [UInt8](count: data.length, repeatedValue: 0)
    if data.length > 0 {
      data.getBytes(&mutableData, length: data.length)
    }
    self.data = mutableData
  }
  
  // MARK: - Simple data types
  
  /**
   Parse `UInt8` from underlying data.
   
   - parameter offset: Offset in bytes from this value should be read
   - parameter bigEndian: Is data in big-endian or little-endian order? If this parameter may is ommited, than `BinaryData`
   setting is used.
   
   - returns: `UInt8` representation of byte at offset.
   - throws: `BinaryDataErrors.NotEnoughData` if there is not enough data.
   */
  public func get(offset: Int, bigEndian: Bool? = nil) throws -> UInt8 {
    guard offset < data.count else { throw BinaryDataErrors.NotEnoughData }
    return data[offset]
  }
  
  /**
   Parse `UInt16` from underlying data.
   
   - parameter offset: Offset in bytes from this value should be read
   - parameter bigEndian: Is data in big-endian or little-endian order? If this parameter may is ommited, than `BinaryData`
   setting is used.
   
   - returns: `UInt16` representation of byte at offset.
   - throws: `BinaryDataErrors.NotEnoughData` if there is not enough data.
   */
  public func get(offset: Int, bigEndian: Bool? = nil) throws -> UInt16 {
    guard offset + 1 < data.count else { throw BinaryDataErrors.NotEnoughData }
    return UInt16.join((data[offset], data[offset + 1]),
                       bigEndian: bigEndian ?? self.bigEndian)
  }
  
  /**
   Parse `UInt32` from underlying data.
   
   - parameter offset: Offset in bytes from this value should be read
   - parameter bigEndian: Is data in big-endian or little-endian order? If this parameter may is ommited, than `BinaryData`
   setting is used.
   
   - returns: `UInt32` representation of byte at offset.
   - throws: `BinaryDataErrors.NotEnoughData` if there is not enough data.
   */
  public func get(offset: Int, bigEndian: Bool? = nil) throws -> UInt32 {
    guard offset + 3 < data.count else { throw BinaryDataErrors.NotEnoughData }
    return UInt32.join((data[offset], data[offset + 1], data[offset + 2], data[offset + 3]),
                       bigEndian: bigEndian ?? self.bigEndian)
  }
  
  /**
   Parse `UInt64` from underlying data.
   
   - parameter offset: Offset in bytes from this value should be read
   - parameter bigEndian: Is data in big-endian or little-endian order? If this parameter may is ommited, than `BinaryData`
   setting is used.
   
   - returns: `UInt64` representation of byte at offset.
   - throws: `BinaryDataErrors.NotEnoughData` if there is not enough data.
   */
  public func get(offset: Int, bigEndian: Bool? = nil) throws -> UInt64 {
    guard offset + 7 < data.count else { throw BinaryDataErrors.NotEnoughData }
    return UInt64.join((data[offset], data[offset + 1], data[offset + 2], data[offset + 3],
      data[offset + 4], data[offset + 5], data[offset + 6], data[offset + 7]),
                       bigEndian: bigEndian ?? self.bigEndian)  }
  
  /**
   Parse `Int8` from underlying data.
   
   - parameter offset: Offset in bytes from this value should be read
   - parameter bigEndian: Is data in big-endian or little-endian order? If this parameter may is ommited, than `BinaryData`
   setting is used.
   
   - returns: `Int8` representation of byte at offset.
   - throws: `BinaryDataErrors.NotEnoughData` if there is not enough data.
   */
  public func get(offset: Int, bigEndian: Bool? = nil) throws -> Int8 {
    let uint: UInt8 = try get(offset, bigEndian: bigEndian ?? self.bigEndian)
    return Int8(bitPattern: uint)
  }
  
  /**
   Parse `Int16` from underlying data.
   
   - parameter offset: Offset in bytes from this value should be read
   - parameter bigEndian: Is data in big-endian or little-endian order? If this parameter may is ommited, than `BinaryData`
   setting is used.
   
   - returns: `Int16` representation of byte at offset.
   - throws: `BinaryDataErrors.NotEnoughData` if there is not enough data.
   */
  public func get(offset: Int, bigEndian: Bool? = nil) throws -> Int16 {
    let uint:UInt16 = try get(offset, bigEndian: bigEndian ?? self.bigEndian)
    return Int16(bitPattern: uint)
  }
  
  /**
   Parse `Int32` from underlying data.
   
   - parameter offset: Offset in bytes from this value should be read
   - parameter bigEndian: Is data in big-endian or little-endian order? If this parameter may is ommited, than `BinaryData`
   setting is used.
   
   - returns: `Int32` representation of byte at offset.
   - throws: `BinaryDataErrors.NotEnoughData` if there is not enough data.
   */
  public func get(offset: Int, bigEndian: Bool? = nil) throws -> Int32 {
    let uint:UInt32 = try get(offset, bigEndian: bigEndian ?? self.bigEndian)
    return Int32(bitPattern: uint)
  }
  
  /**
   Parse `Int64` from underlying data.
   
   - parameter offset: Offset in bytes from this value should be read
   - parameter bigEndian: Is data in big-endian or little-endian order? If this parameter may is ommited, than `BinaryData`
   setting is used.
   
   - returns: `Int64` representation of byte at offset.
   - throws: `BinaryDataErrors.NotEnoughData` if there is not enough data.
   */
  public func get(offset: Int, bigEndian: Bool? = nil) throws -> Int64 {
    let uint:UInt64 = try get(offset, bigEndian: bigEndian ?? self.bigEndian)
    return Int64(bitPattern: uint)
  }
  
  /**
   Parse `Float32` from underlying data.
   
   - parameter offset: Offset in bytes from this value should be read
   - parameter bigEndian: Is data in big-endian or little-endian order? If this parameter may is ommited, than `BinaryData`
   setting is used.
   
   - returns: `Float32` representation of byte at offset.
   - throws: `BinaryDataErrors.NotEnoughData` if there is not enough data.
   */
  public func get(offset: Int) throws -> Float32 {
    let uint:UInt32 = try get(offset)
    return unsafeConversion(uint)
  }
  
  /**
   Parse `Float64` from underlying data.
   
   - parameter offset: Offset in bytes from this value should be read
   - parameter bigEndian: Is data in big-endian or little-endian order? If this parameter may is ommited, than `BinaryData`
   setting is used.
   
   - returns: `Float64` representation of byte at offset.
   - throws: `BinaryDataErrors.NotEnoughData` if there is not enough data.
   */
  public func get(offset: Int) throws -> Float64 {
    let uint:UInt64 = try get(offset)
    return unsafeConversion(uint)
  }
  
  // MARK: - Strings
  
  /**
   Parse null-terminated UTF8 `String` from underlying data.
   
   - parameter offset: Offset in bytes from this value should be read
   
   - returns: Read `String`
   - throws:
      - `BinaryDataErrors.NotEnoughData` if there is not enough data.
      - `BinaryDataErrors.FailedToConvertToString` if there was an error converting byte stream to String.
   */
  public func getNullTerminatedUTF8(offset: Int) throws -> String {
    var utf8 = UTF8()
    var string = ""
    var generator = try subData(offset, data.count - offset).data.generate()
    
    while true {
      switch utf8.decode(&generator) {
      case .Result(let unicodeScalar) where unicodeScalar.value > 0:
        string.append(unicodeScalar)
      case .Result(_):
        break
      case .EmptyInput:
        return string
      case .Error:
        throw BinaryDataErrors.FailedToConvertToString
      }
    }
  }
  
  /**
   Parse UTF8 `String` of known size from underlying data.
   
   - parameter offset: Offset in bytes from this value should be read
   - parameter length: Length in bytes to read
   
   - returns: Read `String`
   - throws:
      - `BinaryDataErrors.NotEnoughData` if there is not enough data.
      - `BinaryDataErrors.FailedToConvertToString` if there was an error converting byte stream to String.
   */
  public func getUTF8(offset: Int, length: Int) throws -> String {
    var utf8 = UTF8()
    var string = ""
    var generator = try subData(offset, length).data.generate()
    
    while true {
      switch utf8.decode(&generator) {
      case .Result(let unicodeScalar):
        string.append(unicodeScalar)
      case .EmptyInput:
        return string
      case .Error:
        throw BinaryDataErrors.FailedToConvertToString
      }
    }
  }
  
  // MARK: - Data manipulation
  
  /**
   Get subdata in range (offset, self.data.length)
   
   - parameter offset: Offset to start of subdata
   
   - returns: Subdata
   - throws: `BinaryDataErrors.NotEnoughData` if there is not enough data.
   */
  public func tail(offset: Int) throws -> BinaryData {
    if offset > data.count {
      throw BinaryDataErrors.NotEnoughData
    }
    
    return try subData(offset, data.count - offset)
  }
  
  /**
   Get subdata in range (offset, length)
   
   - parameter offset: Offset to start of subdata
   - parameter length: Length of subdata
   
   - returns: Subdata
   - throws: `BinaryDataErrors.NotEnoughData` if there is not enough data.
   */
  public func subData(offset: Int, _ length: Int) throws -> BinaryData {
    if offset >= 0 && offset <= data.count && length >= 0 && (offset + length) <= data.count {
      return BinaryData(data: Array(data[offset..<(offset + length)]))
    } else {
      throw BinaryDataErrors.NotEnoughData
    }
  }
}
