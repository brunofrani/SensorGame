//
//  GameStates.swift
//  SensorGame
//
//  Created by Bruno Frani on 10/2/21.
//

import Foundation

/*
 The states of the game where we need to take actions
 */

enum GameState {
  case initial
  case lost
  case won
  
  var description : String {
    switch self {
    case .initial:
      return ""
    case .lost:
      return "You lost the game. Try Again "
    case .won:
      return "Congratulations, you won"
    }
  }
}
