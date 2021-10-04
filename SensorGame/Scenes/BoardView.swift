//
//  BoardView.swift
//  SensorGame
//
//  Created by Bruno Frani on 10/3/21.
//

import SpriteKit
/*
 The view is done programatically and it has a lot of configuration code so it is defined in a separate file
 */

final class BoardView {
  
  private let woodFrameWidth = CGFloat(20)
  private let innerTileWidth = CGFloat(10)
  private let holeNodeRadius = CGFloat(15)
  private let ballNodeRadius = CGFloat(10)
  private let finishNodeRadius = CGFloat(15)
  
  lazy var  ballNode: SKShapeNode = {
    let ballNode = SKShapeNode(circleOfRadius: ballNodeRadius)
    ballNode.name = "ball"
    ballNode.fillColor = .gray
    ballNode.strokeColor = .lightGray
    ballNode.physicsBody = SKPhysicsBody(circleOfRadius: ballNodeRadius)
    ballNode.physicsBody?.restitution = 0.5
    ballNode.physicsBody?.affectedByGravity = false
    ballNode.physicsBody?.categoryBitMask = PhysicsCategory.ball.rawValue
    ballNode.physicsBody?.collisionBitMask = PhysicsCategory.woodTile.rawValue
    ballNode.physicsBody?.contactTestBitMask = PhysicsCategory.hole.rawValue | PhysicsCategory.finish.rawValue
    return ballNode
  }()
  
  private let scene: SKScene
  
  init(scene: SKScene){
    self.scene = scene
  }
  
  //MARK: Helper functions
  
  /// Creates and positions all the nodes programatically. Created all node only using SKShapeNode ( so I don't have to use and manage resources and their physics shape )
  func setupNodes() {
    
    let bottomTile = createWoodTileNode(size: CGSize(width: scene.size.width, height: woodFrameWidth))
    bottomTile.position = CGPoint(x: scene.frame.midX , y: scene.frame.minY + (woodFrameWidth / 2))
    scene.addChild(bottomTile)
    
    let topTile = createWoodTileNode(size: CGSize(width: scene.size.width, height: woodFrameWidth))
    topTile.position = CGPoint(x: scene.frame.midX , y: scene.frame.maxY - (woodFrameWidth / 2))
    scene.addChild(topTile)
    
    let leftTile = createWoodTileNode(size: CGSize(width: woodFrameWidth, height: scene.size.height))
    leftTile.position = CGPoint(x: scene.frame.minX + (woodFrameWidth / 2), y: scene.frame.midY)
    scene.addChild(leftTile)
    
    let rightTile = createWoodTileNode(size: CGSize(width: woodFrameWidth, height: scene.size.height))
    rightTile.position = CGPoint(x: scene.frame.maxX - (woodFrameWidth / 2), y: scene.frame.midY)
    scene.addChild(rightTile)
    
    let firstInnerTile = createWoodTileNode(size: CGSize(width: innerTileWidth, height: scene.size.height - 50))
    firstInnerTile.position = CGPoint(x: scene.frame.width * 3 / 4, y: scene.frame.midY - 50)
    scene.addChild(firstInnerTile)
    
    let secondInnerTile = createWoodTileNode(size: CGSize(width: innerTileWidth, height: scene.size.height - 50))
    secondInnerTile.position = CGPoint(x: scene.frame.width * 2 / 4, y: scene.frame.midY + 50)
    scene.addChild(secondInnerTile)
    
    let thirdInnerTile = createWoodTileNode(size: CGSize(width: innerTileWidth, height: scene.size.height - 50))
    thirdInnerTile.position = CGPoint(x: scene.frame.width * 1 / 4, y: scene.frame.midY - 50)
    scene.addChild(thirdInnerTile)
    
    
    ballNode.position = CGPoint(x: bottomTile.frame.maxX - (woodFrameWidth + (ballNode.frame.width / 2)) , y: bottomTile.frame.maxY + (ballNode.frame.width / 2))
    scene.addChild(ballNode)
    
    
    let finishNode = SKShapeNode(circleOfRadius: finishNodeRadius)
    finishNode.name = "finish"
    finishNode.fillColor = .blue
    finishNode.strokeColor = .lightGray
    finishNode.physicsBody = SKPhysicsBody(circleOfRadius: finishNodeRadius)
    finishNode.physicsBody?.isDynamic = false
    finishNode.physicsBody?.categoryBitMask = PhysicsCategory.finish.rawValue
    finishNode.physicsBody?.contactTestBitMask = PhysicsCategory.ball.rawValue
    finishNode.position = CGPoint(x: bottomTile.frame.minX + (woodFrameWidth + (finishNode.frame.width / 2)), y: bottomTile.frame.maxY + (finishNode.frame.width / 2))
    scene.addChild(finishNode)
    
    let firstHole = createHoleNode()
    firstHole.position = CGPoint(x: rightTile.frame.minX - (firstHole.frame.width / 2), y: scene.frame.height * 1 / 5)
    scene.addChild(firstHole)
    
    let secondHole = createHoleNode()
    secondHole.position = CGPoint(x: firstInnerTile.frame.maxX + (secondHole.frame.width / 2), y: scene.frame.height * 2 / 5)
    scene.addChild(secondHole)
    
    let thirdHole = createHoleNode()
    thirdHole.position = CGPoint(x: rightTile.frame.minX - (thirdHole.frame.width / 2), y: scene.frame.height * 3 / 5)
    scene.addChild(thirdHole)
    
    let fourthHole = createHoleNode()
    fourthHole.position = CGPoint(x: firstInnerTile.frame.maxX + (thirdHole.frame.width / 2), y: scene.frame.height * 4 / 5)
    scene.addChild(fourthHole)
    
    let fifthtHole = createHoleNode()
    fifthtHole.position = CGPoint(x: secondInnerTile.frame.maxX + (fifthtHole.frame.width / 2), y: scene.frame.height * 4 / 5)
    scene.addChild(fifthtHole)
    
    let sixthHole = createHoleNode()
    sixthHole.position = CGPoint(x: firstInnerTile.frame.minX - (sixthHole.frame.width / 2), y: scene.frame.height * 1 / 5)
    scene.addChild(sixthHole)
    
    let seventhHole = createHoleNode()
    seventhHole.position = CGPoint(x: thirdInnerTile.frame.maxX + (seventhHole.frame.width / 2), y: bottomTile.frame.maxY + (seventhHole.frame.width / 2))
    scene.addChild(seventhHole)
    
    let eigthHole = createHoleNode()
    eigthHole.position = CGPoint(x: secondInnerTile.frame.minX - (eigthHole.frame.width / 2), y: scene.frame.height * 3 / 5)
    scene.addChild(eigthHole)
    
    let ninthHole = createHoleNode()
    ninthHole.position = CGPoint(x: leftTile.frame.maxX + (ninthHole.frame.width / 2), y: scene.frame.height * 4 / 5)
    scene.addChild(ninthHole)
    
    let tenthHole = createHoleNode()
    tenthHole.position = CGPoint(x: thirdInnerTile.frame.minX - (ninthHole.frame.width / 2), y: scene.frame.height * 2 / 5)
    scene.addChild(tenthHole)
    
  }
  
  private func createWoodTileNode(size: CGSize) -> SKShapeNode {
    let node = SKShapeNode(rectOf: size)
    node.name = "woodTile"
    node.fillColor = .brown
    node.strokeColor = .lightGray
    node.physicsBody = SKPhysicsBody(rectangleOf: size)
    node.physicsBody?.isDynamic = false
    node.physicsBody?.categoryBitMask = PhysicsCategory.woodTile.rawValue
    node.physicsBody?.collisionBitMask = PhysicsCategory.ball.rawValue
    return node
  }
  
  private func createHoleNode() -> SKShapeNode {
    let node = SKShapeNode(circleOfRadius: holeNodeRadius)
    node.name = "hole"
    node.fillColor = .black
    node.strokeColor = .lightGray
    // Make the physical body smaller so we can simulate te case when the ball touches the hole but it doesn't falls inside.
    node.physicsBody = SKPhysicsBody(circleOfRadius: holeNodeRadius - (ballNodeRadius))
    node.physicsBody?.isDynamic = false
    node.physicsBody?.categoryBitMask = PhysicsCategory.hole.rawValue
    node.physicsBody?.contactTestBitMask = PhysicsCategory.ball.rawValue
    return node
  }
}
