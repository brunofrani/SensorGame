//
//  MotionServiceError.swift
//  SensorGame
//
//  Created by Bruno Frani on 10/6/21.
//

import Foundation

/// Error enum for MotionService with the possible cases that may happen
enum MotionServiceError: Error {
  
  case motionServiceUnavailable
  case unknown
}

extension MotionServiceError: CustomStringConvertible {
  var description: String {
    switch self {
      
    case .motionServiceUnavailable:
      return "Motion service is not available in this device"
    case .unknown:
      return "An unknown error happened"
    }
  }
  
  
}
