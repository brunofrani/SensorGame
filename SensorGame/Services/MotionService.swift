//
//  MotionService.swift
//  SensorGame
//
//  Created by Bruno Frani on 10/3/21.
//

import CoreMotion

final class MotionService {
  
  var timer: Timer? = nil
  // No permission is required for accelerometer, magnetometer and gyroscope.
  private let motionManager = CMMotionManager()
  
  private  var currentGyroData = ThreeAxisData(xValue: 0.0, yValue: 0.0, zValue: 0.0)
  private  var currentAccelerometerData = ThreeAxisData(xValue: 0.0, yValue: 0.0, zValue: 0.0)
  
  
  func diff(newData: inout ThreeAxisData, oldData: ThreeAxisData) -> ThreeAxisData {
    return newData - oldData
  }
  
  func startMotionUpdates() {
    
    if self.motionManager.isDeviceMotionAvailable {
      self.motionManager.deviceMotionUpdateInterval = 1.0 / 10.0  // 10 Hz
      
      let queue = OperationQueue()
      queue.name = "MotionManagerQueue"
      queue.maxConcurrentOperationCount = 1
      motionManager.startDeviceMotionUpdates(to: queue) { (motion, error) in
        // Handle device motion updates
        guard let motion = motion else { return }
        // Get accelerometer sensor data
        var accelerationtData = ThreeAxisData(xValue: motion.userAcceleration.x, yValue: motion.userAcceleration.y, zValue: motion.userAcceleration.z)
        
        
        // Get gyroscope sensor data
        var gyroData = ThreeAxisData(xValue: motion.rotationRate.x, yValue: motion.rotationRate.y, zValue: motion.rotationRate.z)
        
        print(gyroData)
        
        // Get magnetometer sensor data
        motion.magneticField.accuracy
        motion.magneticField.field.x
        motion.magneticField.field.y
        motion.magneticField.field.z
        
        
      }
    }
  }
  
  func stopMotionUpdates() {
    motionManager.stopDeviceMotionUpdates()
  }
  
}
