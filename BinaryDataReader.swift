//
//  BinaryDataReader.swift
//  BinaryData
//
//  Created by Łukasz Kwoska on 09.12.2015.
//  Copyright © 2015 Macoscope Sp. z o.o. All rights reserved.
//

import Foundation

public class BinaryDataReader {
  var readIndex: Int
  let data: BinaryData
  
  public init(_ data: BinaryData, readIndex: Int = 0) {
    self.data = data
    self.readIndex = readIndex
  }
  
  // MARK: - Parsing out simple types
  
  public func read(bigEndian: Bool? = nil) throws -> UInt8 {
    let value: UInt8 = try data.get(readIndex, bigEndian: bigEndian)
    readIndex = readIndex + 1
    return value
  }
  
  public func read(bigEndian: Bool? = nil) throws -> Int8 {
    let value: Int8 = try data.get(readIndex, bigEndian: bigEndian)
    readIndex = readIndex + 1
    return value
  }
  
  public func read(bigEndian: Bool? = nil) throws -> UInt16 {
    let value: UInt16 = try data.get(readIndex, bigEndian: bigEndian)
    readIndex = readIndex + 2
    return value
  }
  
  public func read(bigEndian: Bool? = nil) throws -> Int16 {
    let value: Int16 = try data.get(readIndex, bigEndian: bigEndian)
    readIndex = readIndex + 2
    return value
  }
  
  public func read(bigEndian: Bool? = nil) throws -> UInt32 {
    let value: UInt32 = try data.get(readIndex, bigEndian: bigEndian)
    readIndex = readIndex + 4
    return value
  }
  
  public func read(bigEndian: Bool? = nil) throws -> Int32 {
    let value: Int32 = try data.get(readIndex, bigEndian: bigEndian)
    readIndex = readIndex + 4
    return value
  }
  
  public func read(bigEndian: Bool? = nil) throws -> UInt64 {
    let value: UInt64 = try data.get(readIndex, bigEndian: bigEndian)
    readIndex = readIndex + 8
    return value
  }
  
  public func read(bigEndian: Bool? = nil) throws -> Int64 {
    let value: Int64 = try data.get(readIndex, bigEndian: bigEndian)
    readIndex = readIndex + 8
    return value
  }
  
  public func read() throws -> Float32 {
    let value: Float32 = try data.get(readIndex)
    readIndex = readIndex + 4
    return value
  }
  
  public func read() throws -> Float64 {
    let value: Float64 = try data.get(readIndex)
    readIndex = readIndex + 4
    return value
  }
  
  public func readNullTerminatedUTF8() throws -> String {
    let string = try data.getNullTerminatedUTF8(readIndex)
    readIndex += string.utf8.count
    return string
  }
  
  public func readUTF8(length: Int) throws -> String {
    let string = try data.getUTF8(readIndex, length: length)
    readIndex += length
    return string
  }
}