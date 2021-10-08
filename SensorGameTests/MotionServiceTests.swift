//
//  MotionServiceTests.swift
//  SensorGameTests
//
//  Created by Bruno Frani on 10/8/21.
//

import XCTest
@testable import SensorGame

class MotionServiceTests: XCTestCase {
  

  
  func testCoreMotionWrapperInitialization() throws {
    XCTAssertNoThrow(try! CoreMotionWrapper.singleton.startMotionUpdates { _ in })
  }
  
  func testStopCoreMotionWrapper() {
    XCTAssertNoThrow(CoreMotionWrapper.singleton.stopMotionUpdates())
  }
    
    
    
  
  
}
