//
//  FinishedGameScene.swift
//  SensorGame
//
//  Created by Bruno Frani on 10/3/21.
//

import SpriteKit

///  This class displays a label with the status of the game after is finished.
Also it initializes a new BoardScene when the user taps on the scene.
final class FinishedGameScene: SKScene {

  private let gameStatusMessage: String
  
  private lazy var gameStatusLabel: SKLabelNode = {
    let node = SKLabelNode(text: gameStatusMessage)
    node.numberOfLines = 0
    node.text = gameStatusMessage
    node.fontSize = 20
    node.fontColor = .white
    return node
  }()
  
  init(size: CGSize, message: String) {
    self.gameStatusMessage = message
    super.init(size: size)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func didMove(to view: SKView) {
    gameStatusLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
    addChild(gameStatusLabel)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let boardScene = BoardScene(size: size)
    let transition = SKTransition.fade(withDuration: 0.5)
    self.view?.presentScene(boardScene, transition: transition)
    
  }
}
