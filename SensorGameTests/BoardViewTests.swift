//
//  SensorGameTests.swift
//  SensorGameTests
//
//  Created by Bruno Frani on 10/1/21.
//

import XCTest
@testable import SensorGame

class BoardViewTests: XCTestCase {

  var boardView: BoardView!
  
    override func setUpWithError() throws {
      boardView = BoardView(scene: BoardScene(size: .zero))
    }

    override func tearDownWithError() throws {
      boardView = nil
    }

  
  func testBallNodeProperties() {
    let ball = boardView.ballNode
    XCTAssertNotNil(ball)
    
    XCTAssertEqual(ball.name, "ball")
    XCTAssertEqual(ball.physicsBody?.friction, 0.5)
    XCTAssertEqual(ball.physicsBody?.affectedByGravity, false)
    XCTAssertEqual(ball.physicsBody?.categoryBitMask, PhysicsCategory.ball.rawValue)
    XCTAssertEqual(ball.physicsBody?.collisionBitMask, PhysicsCategory.woodTile.rawValue)
    XCTAssertEqual(ball.physicsBody?.contactTestBitMask, PhysicsCategory.hole.rawValue | PhysicsCategory.finish.rawValue)
    
  }
  
  func testBallNodeWrongProperties() {
    let ball = boardView.ballNode
    XCTAssertFalse(ball.name == "ballNode")
    XCTAssertFalse(ball.fillColor == .blue)
    XCTAssertFalse(ball.strokeColor == .blue)
    XCTAssertNotEqual(ball.physicsBody?.friction, 0.7)
  }
  
  func testWoodTileNodeProperties() {
    let tile = boardView.createWoodTileNode(size: CGSize(width: 10, height: 10))
    XCTAssertNotNil(tile)
    XCTAssertEqual(tile.name, "woodTile")
    XCTAssertEqual(tile.physicsBody?.isDynamic, false)
    XCTAssertEqual(tile.physicsBody?.categoryBitMask, PhysicsCategory.woodTile.rawValue)
    XCTAssertEqual(tile.physicsBody?.collisionBitMask, PhysicsCategory.ball.rawValue)

  }
  
  func testWoodTileNodeWrongProperties() {
    let tile = boardView.createWoodTileNode(size: CGSize(width: 10, height: 10))
    XCTAssertNotEqual(tile.name, "woodTileNode")
    XCTAssertFalse(tile.fillColor == .blue)
    XCTAssertFalse(tile.strokeColor == .blue)

  }
  
  func testHoleNodeProperties() {
    let hole = boardView.createHoleNode()
    XCTAssertEqual(hole.name, "hole")
    XCTAssertNotNil(hole)


    XCTAssertEqual(hole.physicsBody?.isDynamic, false)
    XCTAssertEqual(hole.physicsBody?.categoryBitMask, PhysicsCategory.hole.rawValue)
    XCTAssertEqual(hole.physicsBody?.contactTestBitMask,  PhysicsCategory.ball.rawValue)
  }
  
  func testHoleNodeWrongProperties() {
    let hole = boardView.createHoleNode()
    XCTAssertNotEqual(hole.name, "holeNode")
    XCTAssertFalse(hole.fillColor == .blue)
    XCTAssertFalse(hole.strokeColor == .blue)
  }

  
  func testFinishNodeProperties() {
    let finish = boardView.finishNode
    XCTAssertEqual(finish.name, "finish")
    XCTAssertNotNil(finish)
    XCTAssertEqual(finish.physicsBody?.isDynamic, false)
    XCTAssertEqual(finish.physicsBody?.categoryBitMask, PhysicsCategory.finish.rawValue)
    XCTAssertEqual(finish.physicsBody?.contactTestBitMask,  PhysicsCategory.ball.rawValue)
  }
  
  func testFinishNodeWrongProperties() {
    let finish = boardView.finishNode
    XCTAssertNotEqual(finish.name, "finishNode")
    XCTAssertFalse(finish.fillColor == .red)
    XCTAssertFalse(finish.strokeColor == .red)
    
  }
  
}
