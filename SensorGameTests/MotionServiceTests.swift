//
//  MotionServiceTests.swift
//  SensorGameTests
//
//  Created by Bruno Frani on 10/8/21.
//

import XCTest
@testable import SensorGame

class MotionServiceTests: XCTestCase {
  
  
  func testCoreMotionData() {
    
    let expectation = XCTestExpectation(description: "get data from motion service")
    
    CoreMotionWrapper.singleton.startMotionUpdates(isContinuos: false, handler: { motionData in
      XCTAssertNotNil(motionData.dx)
      XCTAssertNotNil(motionData.dy)
      XCTAssertLessThanOrEqual(motionData.dx, abs(1))
      XCTAssertLessThanOrEqual(motionData.dy, abs(1))
      expectation.fulfill()
    })
    
    wait(for: [expectation], timeout: 1)
  }
  
  func testStopCoreMotionWrapper() {
    XCTAssertNoThrow(CoreMotionWrapper.singleton.stopMotionUpdates())
  }
  
  
  
  
  
}
