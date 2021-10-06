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
  
  //MARK: Variables
  private var isFirstRun = true
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
    
    do {
      try CoreMotionWrapper.singleton.startMotionUpdates { [weak self] motionData in
        guard let strongSelf = self else { return }
        strongSelf.boardView.ballNode.physicsBody?.applyForce(
          CGVector(
            dx: motionData.dx * 10 * motionData.speedMultiplier,
            dy: motionData.dy * 10 * motionData.speedMultiplier))
      }
    } catch {
      // In case of an error end the game right away
      gameState = .lost(message: "An error occoured with motion service")
      
    }
  }
  
  private func showFinishedGameScene(state: GameState) {
    var finishedGameScene: FinishedGameScene? = nil
    switch state {
    case .initial:
      break
    case .lost:
      finishedGameScene = FinishedGameScene(size: size, message: state.description)
      CoreMotionWrapper.singleton.stopMotionUpdates()
    case .won:
      finishedGameScene = FinishedGameScene(size: size, message: state.description)
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
