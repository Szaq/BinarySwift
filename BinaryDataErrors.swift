//
//  BinaryDataErrors.swift
//  BinaryData
//
//  Created by Łukasz Kwoska on 09.12.2015.
//  Copyright © 2015 Macoscope Sp. z o.o. All rights reserved.
//

import Foundation

/**
 Errors thrown by `BinaryData` i `BinaryDataReader`
 */
public enum BinaryDataErrors : ErrorType {
  ///There wasn't enough data to read in current `BinaryData` struct
  case NotEnoughData
  ///Data was supposed to be UTF8, but there was an error parsing it
  case FailedToConvertToString
}