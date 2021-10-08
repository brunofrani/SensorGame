//
//  GameStates.swift
//  SensorGame
//
//  Created by Bruno Frani on 10/2/21.
//

import Foundation

///  The states of the game where we need to take actions
enum GameState: Equatable {
  case initial
  case lost(message: String)
  case won
  
  var description : String {
    switch self {
    case .initial:
      return ""
    case .lost(let message):
      return "\(message). Try Again "
    case .won:
      return "Congratulations, you won"
    }
  }
}
