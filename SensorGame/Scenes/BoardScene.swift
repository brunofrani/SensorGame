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
  
  
  // MARK: Sprite kit components
  
  // Create all node only using SKShapeNode( so I don't have to use an manage resources )
  
  /*
   // create physics bodies for ball
   
   In this case the ball is created by an image
   is assigned a name
   a physics body is created
   
   */
  
  // ball
  // hole
  // finish
  
  // 7 walls
  
  private lazy var ballNode : SKShapeNode = {
    let node = SKShapeNode(circleOfRadius: 10)
    node.name = "ball"
    node.fillColor = .gray
    node.strokeColor = .lightGray
    node.physicsBody = SKPhysicsBody(circleOfRadius: 10)
    node.physicsBody?.isDynamic = false
    node.physicsBody?.categoryBitMask = PhysicsCategory.ball.rawValue
    node.physicsBody?.collisionBitMask = PhysicsCategory.woodTile.rawValue
    node.physicsBody?.contactTestBitMask = PhysicsCategory.hole.rawValue | PhysicsCategory.finish.rawValue
    return node
  }()
  
  private lazy var finishNode: SKShapeNode = {
    let node = SKShapeNode(circleOfRadius: 15)
    node.name = "finish"
    node.fillColor = .blue
    node.strokeColor = .lightGray
    node.physicsBody = SKPhysicsBody(circleOfRadius: 15)
    node.physicsBody?.isResting = true
    node.physicsBody?.categoryBitMask = PhysicsCategory.finish.rawValue
    node.physicsBody?.collisionBitMask = PhysicsCategory.ball.rawValue
    node.physicsBody?.contactTestBitMask = PhysicsCategory.ball.rawValue
    return node
  }()
  
  private lazy var holeNode: SKShapeNode = {
    let node = SKShapeNode(circleOfRadius: 15)
    node.name = "hole"
    node.fillColor = .black
    node.strokeColor = .lightGray
    node.physicsBody = SKPhysicsBody(circleOfRadius: 15)
    node.physicsBody?.isResting = true
    node.physicsBody?.categoryBitMask = PhysicsCategory.hole.rawValue
    node.physicsBody?.collisionBitMask = PhysicsCategory.ball.rawValue
    node.physicsBody?.contactTestBitMask = PhysicsCategory.ball.rawValue
    return node
  }()
  
  
  private lazy var woodTile: SKShapeNode = {
    let node = SKShapeNode(rectOf: CGSize(width: 10, height: 300))
    node.name = "woodTile"
    node.fillColor = .brown
    node.strokeColor = .lightGray
    node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 300))
    node.physicsBody?.isResting = true
    node.physicsBody?.categoryBitMask = PhysicsCategory.woodTile.rawValue
    node.physicsBody?.collisionBitMask = PhysicsCategory.ball.rawValue
    node.physicsBody?.contactTestBitMask = PhysicsCategory.ball.rawValue
    return node
  }()
  
  
  
  //MARK: Lifecycle methods
  override func didMove(to view: SKView) {
    physicsWorld.gravity = .zero
    physicsWorld.contactDelegate = self
    backgroundColor = .white
    setupNodes()
    
  }
  
  private func setupNodes() {
    ballNode.position = CGPoint(x: view!.center.x, y: view!.center.y)
    
    woodTile.position
    addChild(ballNode)
    addChild(finishNode)
    addChild(holeNode)
  }
  
  
  func createWoodFrame() {
    
  }
  
  override func update(_ currentTime: TimeInterval) {
  }
  
}


extension BoardScene: SKPhysicsContactDelegate {
  
  func didBegin(_ contact: SKPhysicsContact) {
    
  }
}
