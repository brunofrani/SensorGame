//
//  MainScene.swift
//  SensorGame
//
//  Created by Bruno Frani on 10/1/21.
//

import SpriteKit

class BoardScene: SKScene {
  
  //MARK: Variables
  var obstacles: [SKNode] = []
  
  
  // Constants used to setup the positions of the views
  let woodFrameWidth = CGFloat(20)
  let innerTileWidth = CGFloat(10)
  let holeNodeRadius = CGFloat(15)
  let ballNodeRadius = CGFloat(10)
  let finishNodeRadius = CGFloat(15)
  
  
  //MARK: Lifecycle methods
  override func didMove(to view: SKView) {
    physicsWorld.gravity = .zero
    physicsWorld.contactDelegate = self
    backgroundColor = .white
    setupNodes()
  }
  
  override func update(_ currentTime: TimeInterval) {
  }
  
  //MARK: Helper functions
  
  /// Creates and positions all the nodes programatically. Created all node only using SKShapeNode ( so I don't have to use and manage resources and their physics shape )
  func setupNodes() {
    
    let bottomTile = createWoodTileNode(size: CGSize(width: size.width, height: woodFrameWidth))
    bottomTile.position = CGPoint(x: self.frame.midX , y: self.frame.minY + (woodFrameWidth / 2))
    addChild(bottomTile)
    
    let topTile = createWoodTileNode(size: CGSize(width: size.width, height: woodFrameWidth))
    topTile.position = CGPoint(x: self.frame.midX , y: self.frame.maxY - (woodFrameWidth / 2))
    addChild(topTile)
    
    let leftTile = createWoodTileNode(size: CGSize(width: woodFrameWidth, height: size.height))
    leftTile.position = CGPoint(x: self.frame.minX + (woodFrameWidth / 2), y: self.frame.midY)
    addChild(leftTile)
    
    let rightTile = createWoodTileNode(size: CGSize(width: woodFrameWidth, height: size.height))
    rightTile.position = CGPoint(x: self.frame.maxX - (woodFrameWidth / 2), y: self.frame.midY)
    addChild(rightTile)
    
    let firstInnerTile = createWoodTileNode(size: CGSize(width: innerTileWidth, height: size.height - 50))
    firstInnerTile.position = CGPoint(x: self.frame.width * 3 / 4, y: self.frame.midY - 50)
    addChild(firstInnerTile)
    
    let secondInnerTile = createWoodTileNode(size: CGSize(width: innerTileWidth, height: size.height - 50))
    secondInnerTile.position = CGPoint(x: self.frame.width * 2 / 4, y: self.frame.midY + 50)
    addChild(secondInnerTile)
    
    let thirdInnerTile = createWoodTileNode(size: CGSize(width: innerTileWidth, height: size.height - 50))
    thirdInnerTile.position = CGPoint(x: self.frame.width * 1 / 4, y: self.frame.midY - 50)
    addChild(thirdInnerTile)
    
    
    let ballNode = SKShapeNode(circleOfRadius: ballNodeRadius)
    ballNode.name = "ball"
    ballNode.fillColor = .gray
    ballNode.strokeColor = .lightGray
    ballNode.physicsBody = SKPhysicsBody(circleOfRadius: ballNodeRadius)
    ballNode.physicsBody?.isDynamic = false
    ballNode.physicsBody?.categoryBitMask = PhysicsCategory.ball.rawValue
    ballNode.physicsBody?.collisionBitMask = PhysicsCategory.woodTile.rawValue
    ballNode.physicsBody?.contactTestBitMask = PhysicsCategory.hole.rawValue | PhysicsCategory.finish.rawValue
    ballNode.position = CGPoint(x: bottomTile.frame.maxX - (woodFrameWidth + (ballNode.frame.width / 2)) , y: bottomTile.frame.maxY + (ballNode.frame.width / 2))
    addChild(ballNode)
    
    
    let finishNode = SKShapeNode(circleOfRadius: finishNodeRadius)
    finishNode.name = "finish"
    finishNode.fillColor = .blue
    finishNode.strokeColor = .lightGray
    finishNode.physicsBody = SKPhysicsBody(circleOfRadius: finishNodeRadius)
    finishNode.physicsBody?.isResting = true
    finishNode.physicsBody?.categoryBitMask = PhysicsCategory.finish.rawValue
    finishNode.physicsBody?.collisionBitMask = PhysicsCategory.ball.rawValue
    finishNode.physicsBody?.contactTestBitMask = PhysicsCategory.ball.rawValue
    finishNode.position = CGPoint(x: bottomTile.frame.minX + (woodFrameWidth + (finishNode.frame.width / 2)), y: bottomTile.frame.maxY + (finishNode.frame.width / 2))
    addChild(finishNode)
    
    let firstHole = createHoleNode()
    firstHole.position = CGPoint(x: rightTile.frame.minX - (firstHole.frame.width / 2), y: self.frame.height * 1 / 5)
    addChild(firstHole)
    
    let secondHole = createHoleNode()
    secondHole.position = CGPoint(x: firstInnerTile.frame.maxX + (secondHole.frame.width / 2), y: self.frame.height * 2 / 5)
    addChild(secondHole)
    
    let thirdHole = createHoleNode()
    thirdHole.position = CGPoint(x: rightTile.frame.minX - (thirdHole.frame.width / 2), y: self.frame.height * 3 / 5)
    addChild(thirdHole)
    
    let fourthHole = createHoleNode()
    fourthHole.position = CGPoint(x: firstInnerTile.frame.maxX + (thirdHole.frame.width / 2), y: self.frame.height * 4 / 5)
    addChild(fourthHole)
    
    let fifthtHole = createHoleNode()
    fifthtHole.position = CGPoint(x: secondInnerTile.frame.maxX + (fifthtHole.frame.width / 2), y: self.frame.height * 4 / 5)
    addChild(fifthtHole)
    
    let sixthHole = createHoleNode()
    sixthHole.position = CGPoint(x: firstInnerTile.frame.minX - (sixthHole.frame.width / 2), y: self.frame.height * 1 / 5)
    addChild(sixthHole)
    
    let seventhHole = createHoleNode()
    seventhHole.position = CGPoint(x: thirdInnerTile.frame.maxX + (seventhHole.frame.width / 2), y: bottomTile.frame.maxY + (seventhHole.frame.width / 2))
    addChild(seventhHole)
    
    let eigthHole = createHoleNode()
    eigthHole.position = CGPoint(x: secondInnerTile.frame.minX - (eigthHole.frame.width / 2), y: self.frame.height * 3 / 5)
    addChild(eigthHole)
    
    let ninthHole = createHoleNode()
    ninthHole.position = CGPoint(x: leftTile.frame.maxX + (ninthHole.frame.width / 2), y: self.frame.height * 4 / 5)
    addChild(ninthHole)
    
    let tenthHole = createHoleNode()
    tenthHole.position = CGPoint(x: thirdInnerTile.frame.minX - (ninthHole.frame.width / 2), y: self.frame.height * 2 / 5)
    addChild(tenthHole)
    
  }
  
  private func createWoodTileNode(size: CGSize) -> SKShapeNode {
    let node = SKShapeNode(rectOf: size)
    node.name = "woodTile"
    node.fillColor = .brown
    node.strokeColor = .lightGray
    node.physicsBody = SKPhysicsBody(rectangleOf: size)
    node.physicsBody?.isResting = true
    node.physicsBody?.categoryBitMask = PhysicsCategory.woodTile.rawValue
    node.physicsBody?.collisionBitMask = PhysicsCategory.ball.rawValue
    node.physicsBody?.contactTestBitMask = PhysicsCategory.ball.rawValue
    return node
  }
  
  private func createHoleNode() -> SKShapeNode {
    let node = SKShapeNode(circleOfRadius: holeNodeRadius)
    node.name = "hole"
    node.fillColor = .black
    node.strokeColor = .lightGray
    node.physicsBody = SKPhysicsBody(circleOfRadius: holeNodeRadius)
    node.physicsBody?.isResting = true
    node.physicsBody?.categoryBitMask = PhysicsCategory.hole.rawValue
    node.physicsBody?.collisionBitMask = PhysicsCategory.ball.rawValue
    node.physicsBody?.contactTestBitMask = PhysicsCategory.ball.rawValue
    return node
  }
  
}


extension BoardScene: SKPhysicsContactDelegate {
  
  func didBegin(_ contact: SKPhysicsContact) {
  }
}
