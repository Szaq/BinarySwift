//
//  BinaryDataTests.swift
//  BinarySwift
//
//  Created by Łukasz Kwoska on 11/04/16.
//  Copyright © 2016 Spinal Development.com. All rights reserved.
//

import XCTest
import BinarySwift

class BinaryDataTests: XCTestCase {
    
    let intData = BinaryData(data: [0xff, 0x11, 0x00, 0xef, 0x76, 0x12, 0x98, 0xff])
    let floatData = BinaryData(data:[0x40, 0x20, 0x00, 0x00])
    let doubleData = BinaryData(data:[0x40, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00])
    
    func doManyTimes(block: () -> Void)  {
        for _ in 0 ..< 10000 {
            block()
        }
    }
  
    //MARK: - Initialization
    
    func testArrayLiteralInit() {
        let data:BinaryData = [0xf, 0x00, 0x1, 0xa]
        XCTAssertEqual(data.data, [0xf, 0x00, 0x1, 0xa])
        XCTAssertTrue(data.bigEndian)
    }
    
    func testArrayInit() {
        let data = BinaryData(data: [0xf, 0x00, 0x1, 0xa])
        XCTAssertEqual(data.data, [0xf, 0x00, 0x1, 0xa])
        XCTAssertTrue(data.bigEndian)
        
        let dataExplicitBigEndianTrue = BinaryData(data: [0xf, 0x00, 0x1, 0xa], bigEndian: true)
        XCTAssertEqual(dataExplicitBigEndianTrue.data, [0xf, 0x00, 0x1, 0xa])
        XCTAssertTrue(dataExplicitBigEndianTrue.bigEndian)
        
        let dataExplicitBigEndianFalse = BinaryData(data: [0xf, 0x00, 0x1, 0xa], bigEndian: false)
        XCTAssertEqual(dataExplicitBigEndianFalse.data, [0xf, 0x00, 0x1, 0xa])
        XCTAssertFalse(dataExplicitBigEndianFalse.bigEndian)
    }
    
    func testNSDataInit() {
        guard let nsData = NSData(base64EncodedString: "MTIzNA==", options: NSDataBase64DecodingOptions())
            else { XCTFail("Failed to decode test Base64 string"); return}
        
        let data = BinaryData(data: nsData)
        XCTAssertEqual(data.data, [49, 50, 51, 52])
        XCTAssertTrue(data.bigEndian)
        
        let dataExplicitBigEndianTrue = BinaryData(data: nsData, bigEndian: true)
        XCTAssertEqual(dataExplicitBigEndianTrue.data, [49, 50, 51, 52])
        XCTAssertTrue(dataExplicitBigEndianTrue.bigEndian)
        
        let dataExplicitBigEndianFalse = BinaryData(data: nsData, bigEndian: false)
        XCTAssertEqual(dataExplicitBigEndianFalse.data, [49, 50, 51, 52])
        XCTAssertFalse(dataExplicitBigEndianFalse.bigEndian)
    }
    
  
    
    //MARK: - Reading One - byte values
    
    func testGetUInt8() {
        let value: UInt8? = try? intData.get(0)
        XCTAssertEqual(value, 255)
    }
    
    func testPerformanceGetUInt8() {
        self.measureBlock {
            self.doManyTimes {
                let _: UInt8? = try? self.intData.get(0)
            }
        }
    }
    
    func testGetInt8() {
        let value: Int8? = try? intData.get(0)
        XCTAssertEqual(value, -1)
    }
    
    func testPerformanceGetInt8() {
        self.measureBlock {
            self.doManyTimes {
                let _: Int8? = try? self.intData.get(0)
            }
        }
    }
    
    
    //MARK: - Reading Two - byte values
    
    func testGetUInt16() {
        let value: UInt16? = try? intData.get(0)
        XCTAssertEqual(value, 65297)
    }
    
    func testPerformanceGetUInt16() {
        self.measureBlock {
            self.doManyTimes {
                let _: UInt16? = try? self.intData.get(0)
            }
        }
    }
    
    func testGetInt16() {
        let value: Int16? = try? intData.get(0)
        XCTAssertEqual(value, -239)
    }
    
    func testPerformanceGetInt16() {
        self.measureBlock {
            self.doManyTimes {
                let _: Int16? = try? self.intData.get(0)
            }
        }
    }
    
    func testGetUInt16LittleEndian() {
        let value: UInt16? = try? intData.get(0, bigEndian:false)
        XCTAssertEqual(value, 4607)
    }
    
    func testPerformanceGetUInt16LittleEndian() {
        self.measureBlock {
            self.doManyTimes {
                let _: UInt16? = try? self.intData.get(0, bigEndian:false)
            }
        }
    }
    
    func testGetInt16LittleEndian() {
        let value: Int16? = try? intData.get(0, bigEndian:false)
        XCTAssertEqual(value, 4607)
    }
    
    func testPerformanceGetInt16LittleEndian() {
        self.measureBlock {
            self.doManyTimes {
                let _: Int16? = try? self.intData.get(0, bigEndian:false)
            }
        }
    }
    
    //MARK: - Reading Four - byte values
    
    func testGetUInt32() {
        let value: UInt32? = try? intData.get(0)
        XCTAssertEqual(value, 4279304431)
    }
    
    func testPerformanceGetUInt32() {
        self.measureBlock {
            self.doManyTimes {
                let _: UInt32? = try? self.intData.get(0)
            }
        }
    }
    
    func testGetInt32() {
        let value: Int32? = try? intData.get(0)
        XCTAssertEqual(value, -15662865)
    }
    
    func testPerformanceGetInt32() {
        self.measureBlock {
            self.doManyTimes {
                let _: Int32? = try? self.intData.get(0)
            }
        }
    }
    
    func testGetUInt32LittleEndian() {
        let value: UInt32? = try? intData.get(0, bigEndian:false)
        XCTAssertEqual(value, 4009759231)
    }
    
    func testPerformanceGetUInt32LittleEndian() {
        self.measureBlock {
            self.doManyTimes {
                let _: UInt32? = try? self.intData.get(0, bigEndian:false)
            }
        }
    }
    
    func testGetInt32LittleEndian() {
        let value: Int32? = try? intData.get(0, bigEndian:false)
        XCTAssertEqual(value, -285208065)
    }
    
    func testPerformanceGetInt32LittleEndian() {
        self.measureBlock {
            self.doManyTimes {
                let _: Int32? = try? self.intData.get(0, bigEndian:false)
            }
        }
    }

    //MARK: - Reading Eight - byte values
    
    func testGetUInt64() {
        let value: UInt64? = try? intData.get(0)
        XCTAssertEqual(value, 18379472582753818879)
    }
    
    func testPerformanceGetUInt64() {
        self.measureBlock {
            self.doManyTimes {
                let _: UInt64? = try? self.intData.get(0)
            }
        }
    }
    
    func testGetInt64() {
        let value: Int64? = try? intData.get(0)
        XCTAssertEqual(value, -67271490955732737)
    }
    
    func testPerformanceGetInt64() {
        self.measureBlock {
            self.doManyTimes {
                let _: Int64? = try? self.intData.get(0)
            }
        }
    }
    
    func testGetUInt64LittleEndian() {
        let value: UInt64? = try? intData.get(0, bigEndian:false)
        XCTAssertEqual(value, 18417490978156843519)
    }
    
    func testPerformanceGetUInt64LittleEndian() {
        self.measureBlock {
            self.doManyTimes {
                let _: UInt64? = try? self.intData.get(0, bigEndian:false)
            }
        }
    }
    
    func testGetInt64LittleEndian() {
        let value: Int64? = try? intData.get(0, bigEndian:false)
        XCTAssertEqual(value, -29253095552708097)
    }
    
    func testPerformanceGetInt64LittleEndian() {
        self.measureBlock {
            self.doManyTimes {
                let _: Int64? = try? self.intData.get(0, bigEndian:false)
            }
        }
    }
    
    //MARK: - Reading Floats
    
    func testGetFloat32() {
        let value: Float32? = try? floatData.get(0)
        XCTAssertEqual(value, 2.5)
    }
    
    func testPerformanceGetFloat32() {
        self.measureBlock {
            self.doManyTimes {
                let _: Float32? = try? self.floatData.get(0)
            }
        }
    }
    
    func testGetFloat64() {
        let value: Float64? = try? doubleData.get(0)
        XCTAssertEqual(value, 8.0)
    }
    
    func testPerformanceGetFloat64() {
        self.measureBlock {
            self.doManyTimes {
                let _: Float64? = try? self.doubleData.get(0)
            }
        }
    }
    
    //MARK: - Test reading String
    func testGetNullTerminatedString() {
        let testString = "TestData"
        let bytes = Array(testString.nulTerminatedUTF8)
        let data = BinaryData(data: bytes + bytes)
        print (bytes)
        XCTAssertEqual(try? data.getNullTerminatedUTF8(0), testString)
    }
    
    func testPerformanceGetNullTerminatedString() {
        self.measureBlock {
            self.doManyTimes {
                let testString = "TestData"
                let data = BinaryData(data: Array(testString.nulTerminatedUTF8))
                let _ = try? data.getNullTerminatedUTF8(0)
            }
        }
    }
    
    func testGetString() {
        let testString = "Test"
        let data = BinaryData(data: Array(testString.nulTerminatedUTF8))
        XCTAssertEqual(try? data.getUTF8(0, length: 4), testString)
    }
    
    func testPerformanceGetString() {
        self.measureBlock {
            self.doManyTimes {
                let testString = "Test"
                let data = BinaryData(data: Array(testString.nulTerminatedUTF8))
                let _ = try? data.getUTF8(0, length: 4)
            }
        }
    }
  
  //MARK: - Test reading subdata
  
  func testGetSubData() {
    XCTAssertEqual((try? intData.subData(1, 2).data) ?? [], [0x11, 0x00])
  }
  
  func testPerformanceGetSubData() {
    self.measureBlock {
      self.doManyTimes {
        let _ = try? self.intData.subData(1, 2)
      }
    }
  }
  
  func testTail() {
    XCTAssertEqual((try? intData.tail(1).data) ?? [], [0x11, 0x00, 0xef, 0x76, 0x12, 0x98, 0xff])
  }
  
  func testPerformanceTail() {
    self.measureBlock {
      self.doManyTimes {
        let _ = try? self.intData.tail(1)
      }
    }
  }

}