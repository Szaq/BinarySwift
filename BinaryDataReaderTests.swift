//
//  BinaryDataReaderTests.swift
//  BinarySwift
//
//  Created by Łukasz Kwoska on 12/04/16.
//  Copyright © 2016 Spinal Development.com. All rights reserved.
//

import XCTest
import BinarySwift


class BinaryDataReaderTests: XCTestCase {
    func testReadUInt8() {
        let reader = BinaryDataReader(BinaryData(data:[0xff, 0x05]))
        XCTAssertEqual(try? reader.read() as UInt8, 255)
        XCTAssertEqual(try? reader.read() as UInt8, 5)
        XCTAssertNil(try? reader.read() as UInt8?)
    }
    
    func testReadInt8() {
        let reader = BinaryDataReader(BinaryData(data:[0xff, 0x05]))
        XCTAssertEqual(try? reader.read() as Int8, -1)
        XCTAssertEqual(try? reader.read() as Int8, 5)
        XCTAssertNil(try? reader.read() as Int8?)
    }
    
    func testReadUInt16() {
        let reader = BinaryDataReader(BinaryData(data:[0xff, 0x00, 0xcc, 0x00, 0x00]))
        XCTAssertEqual(try? reader.read() as UInt16, 0xff00)
        XCTAssertEqual(try? reader.read() as UInt16, 0xcc00)
        XCTAssertNil(try? reader.read() as UInt16?)
    }
    
    func testReadInt16() {
        let reader = BinaryDataReader(BinaryData(data:[0xff, 0x00, 0xcc, 0x00, 0x00]))
        XCTAssertEqual(try? reader.read() as Int16, -256)
        XCTAssertEqual(try? reader.read() as Int16, -13312)
        XCTAssertNil(try? reader.read() as Int16?)
    }
    
    func testReadUInt32() {
        let reader = BinaryDataReader(BinaryData(data:[0xff, 0x00, 0xcc, 0x11, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00]))
        XCTAssertEqual(try? reader.read() as UInt32, 0xff00cc11)
        XCTAssertEqual(try? reader.read() as UInt32, 5)
        XCTAssertNil(try? reader.read() as UInt32?)
    }
    
    func testReadInt32() {
        let reader = BinaryDataReader(BinaryData(data:[0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00]))
        XCTAssertEqual(try? reader.read() as Int32, -16777216)
        XCTAssertEqual(try? reader.read() as Int32, 255)
        XCTAssertNil(try? reader.read() as Int32?)
    }
    
    func testReadUInt64() {
        let reader = BinaryDataReader(BinaryData(data:[0xff, 0x00, 0xcc, 0x11, 0x00, 0x00, 0x00, 0xab, 0x00, 0x00, 0x00, 0x00, 0x00]))
        XCTAssertEqual(try? reader.read() as UInt64, 0xff00cc11000000ab)
        XCTAssertNil(try? reader.read() as UInt64?)
    }
    
    func testReadInt64() {
        let reader = BinaryDataReader(BinaryData(data:[0xff, 0x00, 0xcc, 0x11, 0x00, 0x00, 0x00, 0xab, 0x00, 0x00, 0x00, 0x00, 0x00]))
        XCTAssertEqual(try? reader.read() as Int64, -71833220651417429)
        XCTAssertNil(try? reader.read() as Int64?)

    }
    
    func testReadFloat32() {
        let reader = BinaryDataReader(BinaryData(data:[0x40, 0x20, 0x00, 0x00, 0x40, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00]))
        XCTAssertEqual(try? reader.read() as Float32, 2.5)
        XCTAssertEqual(try? reader.read() as Float32, 2.75)
        XCTAssertNil(try? reader.read() as Float32?)
        
    }
    
    func testReadFloat64() {
        let reader = BinaryDataReader(BinaryData(data:[0x40, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]))
        XCTAssertEqual(try? reader.read() as Float64, 8.0)
        XCTAssertEqual(try? reader.read() as Float64, 16.0)
        XCTAssertNil(try? reader.read() as Float64?)
    }
    
    func testReadNullTerminatedString() {
        let string = "Test string"
        let bytes = Array(string.nulTerminatedUTF8)
        let reader = BinaryDataReader(BinaryData(data: bytes + bytes + [0x0, 0x12]))
        
        XCTAssertEqual(try? reader.readNullTerminatedUTF8(), string)
        XCTAssertEqual(try? reader.readNullTerminatedUTF8(), string)
        XCTAssertEqual(try? reader.readNullTerminatedUTF8(), "")
        XCTAssertNil(try? reader.readNullTerminatedUTF8())
    }
    
    func testReadString() {
        let string = "Test string"
        let bytes = Array(string.utf8)
        let reader = BinaryDataReader(BinaryData(data: bytes + bytes + [0x0, 0x12]))
        
        XCTAssertEqual(try? reader.readUTF8(11), string)
        XCTAssertEqual(try? reader.readUTF8(11), string)
        XCTAssertEqual(try? reader.readUTF8(0), "")
        XCTAssertNil(try? reader.readUTF8(11))
    }
    
    func testReadSubData() {
        let reader = BinaryDataReader(BinaryData(data:[0x40, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]))
        let subdata1 = try? reader.read(8) as BinaryData
        let subdata2 = try? reader.read(8) as BinaryData
        XCTAssertEqual(subdata1?.data ?? [], [0x40, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00])
        XCTAssertEqual(subdata2?.data ?? [], [0x40, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00])
    }
}
