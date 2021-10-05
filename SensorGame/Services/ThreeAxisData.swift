//
//  ThreeAxisData.swift
//  SensorGame
//
//  Created by Bruno Frani on 10/4/21.
//

import Foundation

// Represents the data that the sensors output
struct ThreeAxisData {
  
  var xValue: Double
  var yValue: Double
  var zValue: Double
}


/// Custom operator
extension ThreeAxisData {
  static func - ( lhs: inout ThreeAxisData, rhs: ThreeAxisData) -> Self {
    return ThreeAxisData(
      xValue: lhs.xValue - rhs.xValue,
      yValue: lhs.yValue - rhs.yValue,
      zValue: lhs.zValue - rhs.yValue)
  }
}
