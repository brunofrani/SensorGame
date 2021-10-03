//
//  MainScene.swift
//  SensorGame
//
//  Created by Bruno Frani on 10/1/21.
//

import SpriteKit
/*
 The main SpriteKitScene that holds the actions and delegates
 */

final class BoardScene: SKScene {
  
  //MARK: Variables
 private var gameState: GameState = .initial {
    willSet {
      showFinishedGameScene(state: newValue)
    }
  }
  
  private lazy var boardView: BoardView = {
   return BoardView(scene: self)
  }()
  
  
  //MARK: Lifecycle methods
  override func didMove(to view: SKView) {
    physicsWorld.gravity = .zero
    physicsWorld.contactDelegate = self
    backgroundColor = .white
    gameState = .initial
    boardView.setupNodes()
  }
  
  private func showFinishedGameScene(state: GameState) {
    var finishedGameScene: FinishedGameScene? = nil
    switch state {
    case .initial:
      break
    case .lost:
      finishedGameScene = FinishedGameScene(size: size, message: state.description)
    case .won:
      finishedGameScene = FinishedGameScene(size: size, message: state.description)
    }
    guard let finishScene = finishedGameScene else { return }
    
    finishScene.scaleMode = .aspectFill
    let transition = SKTransition.moveIn(with: .down, duration: 0.8)
    self.view?.presentScene(finishScene, transition: transition)
  }
  
  // MARK: Action
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      let touchLocation = touch.location(in: self)
      
      let movementVector = CGVector(dx: touchLocation.x - boardView.ballNode.position.x, dy: touchLocation.y - boardView.ballNode.position.y)
      let move = SKAction.move(by: movementVector, duration: 0.5)
      boardView.ballNode.run(move)
    }
  }

}



// MARK: Contact delegate
extension BoardScene: SKPhysicsContactDelegate {
  
  /*
   Collision possibilities
   ball -> hole
   ball -> finish
   */
  
  func didBegin(_ contact: SKPhysicsContact) {
    guard let nodeA = contact.bodyA.node else { return }
    guard let nodeB = contact.bodyB.node else { return }
    
    if nodeA.name == "ball" {
      if nodeB.name == "hole" {
        //  ball contacted hole -> game lost
        gameState =  .lost
      } else if nodeB.name == "finish" {
        // ball contacted finish -> game won
        gameState = .won
      }
    }
    
  }
  
}
