//
//  BoardSceneTests.swift
//  SensorGameTests
//
//  Created by Bruno Frani on 10/8/21.
//

import XCTest
@testable import SensorGame
import SpriteKit

class BoardSceneTests: XCTestCase {
  
  func testBoardSceneInitialization() {
    
    let scene = BoardScene(size: CGSize(width: 200, height: 500))
    
    XCTAssertNotNil(scene)
    XCTAssertEqual(scene.children.count, 20)
    XCTAssertEqual(scene.gameState, .initial)
    
  }
  
}
