//
//  CollisionDetection.swift
//  SensorGame
//
//  Created by Bruno Frani on 10/2/21.
//

import Foundation

/*
 An enum to predefine SKPhysicsBody properties to configure different objects with separate categories that have the same behaviours.
 This is also used to configure and detect the categories of the bodies that collide or contact each other.
 */

enum PhysicsCategory: UInt32 {
  
  case ball = 1
  case woodTile = 2
  case hole = 4
  case finish = 8
}
