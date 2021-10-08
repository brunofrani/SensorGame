//
//  FinishGameTests.swift
//  SensorGameTests
//
//  Created by Bruno Frani on 10/8/21.
//

import XCTest
@testable import SensorGame

class FinishGameTests: XCTestCase {

  
  func testWonFinishGameProperties() {
    let finishScene = FinishedGameScene(size: .zero, state: .won)
    XCTAssertNotNil(finishScene)
    XCTAssertEqual(finishScene.gameStatusLabel.text, GameState.won.description)
    XCTAssertEqual(finishScene.gameStatusLabel.text, finishScene.gameState.description)
    
  }

  func testLostFinishGameProperties() {
    let finishScene = FinishedGameScene(size: .zero, state: .lost(message: "You lost, try again"))
    XCTAssertNotNil(finishScene)
    XCTAssertEqual(finishScene.gameStatusLabel.text, GameState.lost(message: "You lost, try again").description)
    XCTAssertEqual(finishScene.gameStatusLabel.text, finishScene.gameState.description)
  }
}
