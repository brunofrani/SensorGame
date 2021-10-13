//
//  MainScene.swift
//  SensorGame
//
//  Created by Bruno Frani on 10/1/21.
//

import SpriteKit
import CoreMotion

///  The main SpriteKitScene that holds the actions and delegates
final class BoardScene: SKScene {
  
  private (set) var boardView: BoardView?
  
  override init(size: CGSize) {
    super.init(size: size)
    boardView = BoardView(scene: self)
    boardView?.setupNodes()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: Variables
  var gameState: GameState = .initial {
    willSet {
      finishGame(with: newValue)
    }
  }
  
  //MARK: Lifecycle methods
  override func didMove(to view: SKView) {
    physicsWorld.gravity = .zero
    physicsWorld.contactDelegate = self
    backgroundColor = .white
    gameState = .initial
    
    CoreMotionWrapper.singleton.startMotionUpdates { [weak self] motionData in
      guard let strongSelf = self else { return }
      strongSelf.boardView?.ballNode.physicsBody?.applyForce(
        CGVector(
          dx: motionData.dx * 8 ,
          dy: motionData.dy * 8 ))
    }
  }
  
  private func finishGame(with state: GameState) {
    var finishedGameScene: FinishedGameScene? = nil
    switch  state {
    case .initial:
      break
    case .lost:
      finishedGameScene = FinishedGameScene(size: size, state: state)
      CoreMotionWrapper.singleton.stopMotionUpdates()
    case .won:
      finishedGameScene = FinishedGameScene(size: size, state: state)
    }
    guard let finishScene = finishedGameScene else { return }
    
    finishScene.scaleMode = .aspectFill
    let transition = SKTransition.moveIn(with: .down, duration: 0.8)
    self.view?.presentScene(finishScene, transition: transition)
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
        gameState =  .lost(message: "You lost")
      } else if nodeB.name == "finish" {
        // ball contacted finish -> game won
        gameState = .won
      }
    } else if nodeB.name == "ball" {
      if nodeA.name == "hole" {
        //ball contacted hole -> game lost
        gameState = .lost(message: "You lost")
      } else if nodeA.name == "finish" {
        // ball contacted finish -> game won
        gameState = .won
      }
    }
    
  }
  
}
