//
//  MotionService.swift
//  SensorGame
//
//  Created by Bruno Frani on 10/3/21.
//

import CoreMotion

/// A protocol that describes the API of the CoreMotionWrapper
protocol MotionService {
  func startMotionUpdates(handler: @escaping (BallMovementVector) -> Void) throws
  func stopMotionUpdates()
}

/// The wrapper of the CMMotionManager
final class CoreMotionWrapper: MotionService {
  
  static let singleton = CoreMotionWrapper()
  // No permission is required for accelerometer, magnetometer and gyroscope.
  private let motionManager = CMMotionManager()
  private let motionUpdateInterval = 1.0 / 60.0  // 60 Hz
  
  func startMotionUpdates(handler: @escaping (BallMovementVector) -> Void) throws {
    
    let queue = OperationQueue()
    queue.name = "MotionManagerQueue"
    queue.maxConcurrentOperationCount = 1
    queue.qualityOfService = .userInteractive
    
    // The motion.gravity attribute is a fusion of accelerometer and gyroscope so it is more accurate.
    if motionManager.isDeviceMotionAvailable {
      motionManager.deviceMotionUpdateInterval = motionUpdateInterval
      motionManager.startDeviceMotionUpdates(to: queue) { (motion, error) in
        guard let motion = motion, error == nil else { return }
        
        let multiplier = 1 / fabs(motion.gravity.z)
        let ballMovementVector = BallMovementVector(dx: motion.gravity.x , dy: motion.gravity.y, speedMultiplier: multiplier)
        handler(ballMovementVector)
        
      }
    } else {
      throw MotionServiceError.motionServiceUnavailable
    }
  }
  
  func stopMotionUpdates() {
    motionManager.stopDeviceMotionUpdates()
  }
  
}
