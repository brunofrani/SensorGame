//
//  MotionService.swift
//  SensorGame
//
//  Created by Bruno Frani on 10/3/21.
//

import CoreMotion

/// A protocol that describes the API of the CoreMotionWrapper
protocol MotionService {
  func startMotionUpdates(isContinuos:Bool, handler: @escaping (BallMovementVector) -> Void)
  func stopMotionUpdates()
}

/// The wrapper of the CMMotionManager
final class CoreMotionWrapper: MotionService {
  
  static let singleton = CoreMotionWrapper()
  // No permission is required for accelerometer, magnetometer and gyroscope.
  private let motionManager = CMMotionManager()
  private let motionUpdateInterval = 1.0 / 60.0  // 60 Hz
  private var timer: Timer? = nil
  
  
  func startMotionUpdates(isContinuos: Bool = true, handler: @escaping (BallMovementVector) -> Void) {
    guard motionManager.isDeviceMotionAvailable else { return }
    motionManager.startDeviceMotionUpdates()
    // Configure a timer to fetch the motion data.
    self.timer = Timer(fire: Date(), interval: motionUpdateInterval, repeats: isContinuos,
                       block: { [weak self] (timer) in
      
      if let data = self?.motionManager.deviceMotion {
        
        let ballMovementVector = BallMovementVector(dx: data.gravity.x , dy: data.gravity.y)
        handler(ballMovementVector)
      }
    })
    
    // Add the timer to the current run loop.
    RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
  }
  
  func stopMotionUpdates() {
    motionManager.stopDeviceMotionUpdates()
  }
  
}
