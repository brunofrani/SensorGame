//
//  GameViewController.swift
//  SensorGame
//
//  Created by Bruno Frani on 10/1/21.
//

import UIKit
import SpriteKit


/*
 The initial ViewController of the game
 It is responsible for instatiating the first SpriteKitScene
 */
class GameViewController: UIViewController {
  
  //Create a the instance of motionService here as this is the parent ViewController of the scenes and lives as long as the app is active.
  private lazy var motionService: MotionService = {
    return MotionService()
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    motionService.startGyros()
    if let view = self.view as! SKView? {
      // Load the SKScene from 'GameScene.sks'
      let scene = BoardScene(size: view.bounds.size)
      // Set the scale mode to scale to fit the window
      scene.scaleMode = .aspectFill
      view.presentScene(scene)
      
      view.ignoresSiblingOrder = true
      // Attributes shown in scenes for debug purposes
      view.showsFPS = true
      view.showsNodeCount = true
      view.showsPhysics = true
    }
  }
  
  override var shouldAutorotate: Bool {
    return false
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .portrait
    } else {
      return .all
    }
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
