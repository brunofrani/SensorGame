//
//  CollisionDetection.swift
//  SensorGame
//
//  Created by Bruno Frani on 10/2/21.
//

import Foundation

// An enum to predefine SKPhysicsBody properties to configure and detect collisions between objects

enum PhysicsCategory: UInt32 {
  
  case ball = 1
  case woodTile = 2
  case hole = 4
  case finish = 8
}
