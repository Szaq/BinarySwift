//
//  Common.swift
//  BinaryData
//
//  Created by Łukasz Kwoska on 09.12.2015.
//  Copyright © 2015 Macoscope Sp. z o.o. All rights reserved.
//

import Foundation

func unsafeConversion<FROM, TO>(from: FROM) -> TO {
  func ptr(fromPtr: UnsafePointer<FROM>) -> UnsafePointer<TO> {
    return UnsafePointer<TO>(fromPtr)
  }
  
  var fromVar = from
  return ptr(&fromVar).memory
}
