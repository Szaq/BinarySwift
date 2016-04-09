//
//  BinaryData.swift
//  BinaryData
//
//  Created by Łukasz Kwoska on 08.12.2015.
//  Copyright © 2015 Macoscope Sp. z o.o. All rights reserved.
//

import Foundation


public struct BinaryData : ArrayLiteralConvertible {
  public typealias Element = UInt8
  let data: [UInt8]
  let bigEndian: Bool
  
  // MARK: - Initializers
  
  public init(arrayLiteral elements: Element...) {
    data = elements
    bigEndian = true
  }
  
  public init(data: [UInt8], bigEndian: Bool = true) {
    self.data = data
    self.bigEndian = bigEndian
  }
  
  public init(data:NSData, bigEndian: Bool = true) {
    
    self.bigEndian = bigEndian
    
    var mutableData = [UInt8](count: data.length, repeatedValue: 0)
    if data.length > 0 {
      data.getBytes(&mutableData, length: data.length)
    }
    self.data = mutableData
  }
  
  // MARK: - Simple data types
  
  public func get(offset: Int, bigEndian: Bool? = nil) throws -> UInt8 {
    if (data.count > offset) {
      return data[offset]
    } else {
      throw BinaryDataErrors.NotEnoughData
    }
  }
  
  public func get(offset: Int, bigEndian: Bool? = nil) throws -> UInt16 {
    return UInt16.join((try get(offset), try get(offset + 1)),
      bigEndian: bigEndian ?? self.bigEndian)
  }
  
  public func get(offset: Int, bigEndian: Bool? = nil) throws -> UInt32 {
    return UInt32.join((try get(offset), try get(offset + 1), try get(offset + 2), try get(offset + 3)),
      bigEndian: bigEndian ?? self.bigEndian)
  }
  
  public func get(offset: Int, bigEndian: Bool? = nil) throws -> UInt64 {
    return UInt64.join((try get(offset), try get(offset + 1), try get(offset + 2), try get(offset + 3),
      try get(offset + 4), try get(offset + 5), try get(offset + 6), try get(offset + 7)),
      bigEndian: bigEndian ?? self.bigEndian)
  }
  
  public func get(offset: Int, bigEndian: Bool? = nil) throws -> Int8 {
    let uint: UInt8 = try get(offset, bigEndian: bigEndian ?? self.bigEndian)
    return Int8(bitPattern: uint)
  }
  
  public func get(offset: Int, bigEndian: Bool? = nil) throws -> Int16 {
    let uint:UInt16 = try get(offset, bigEndian: bigEndian ?? self.bigEndian)
    return Int16(bitPattern: uint)
  }
  
  public func get(offset: Int, bigEndian: Bool? = nil) throws -> Int32 {
    let uint:UInt32 = try get(offset, bigEndian: bigEndian ?? self.bigEndian)
    return Int32(bitPattern: uint)
  }
  
  public func get(offset: Int, bigEndian: Bool? = nil) throws -> Int64 {
    let uint:UInt64 = try get(offset, bigEndian: bigEndian ?? self.bigEndian)
    return Int64(bitPattern: uint)
  }
  
  public func get(offset: Int) throws -> Float32 {
    let uint:UInt32 = try get(offset)
    return unsafeConversion(uint)
  }
  
  public func get(offset: Int) throws -> Float64 {
    let uint:UInt64 = try get(offset)
    return unsafeConversion(uint)
  }
  
  // MARK: - Strings
  
  public func getNullTerminatedUTF8(offset: Int) throws -> String {
    var utf8 = UTF8()
    var string = ""
    var generator = try subData(offset, data.count - offset).data.generate()
    
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
  
  public func tail(offset: Int) throws -> BinaryData {
    if offset > data.count {
      throw BinaryDataErrors.NotEnoughData
    }
    
    return try subData(offset, data.count - offset)
  }
  
  public func subData(offset: Int, _ length: Int) throws -> BinaryData {
    if offset >= 0 && offset <= data.count && length >= 0 && (offset + length) <= data.count {
      return BinaryData(data: Array(data[offset..<(offset + length)]))
    } else {
      throw BinaryDataErrors.NotEnoughData
    }
  }
}
