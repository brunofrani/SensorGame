//
//  MotionService.swift
//  SensorGame
//
//  Created by Bruno Frani on 10/3/21.
//

import CoreMotion

final class MotionService {
  
  // No permission is required for accelerometer, magnetometer and gyroscope.
  let motion = CMMotionManager()
  var timer: Timer?
  
  func startAccelerometers() {
     // Make sure the accelerometer hardware is available.
     if self.motion.isAccelerometerAvailable {
        self.motion.accelerometerUpdateInterval = 1.0 / 10.0  // 60 Hz
        self.motion.startAccelerometerUpdates()

        // Configure a timer to fetch the data.
        self.timer = Timer(fire: Date(), interval: (1.0/10.0),
              repeats: true, block: { (timer) in
           // Get the accelerometer data.
           if let data = self.motion.accelerometerData {
              let x = data.acceleration.x
              let y = data.acceleration.y
              let z = data.acceleration.z
//             print("x   ", x)
//             print("y   ", y)
//             print("z   ", z)
//             print(x,y,z)

              // Use the accelerometer data in your app.
           }
        })

        // Add the timer to the current run loop.
       RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
     }
  }
  
  
  func startGyros() {
     if motion.isGyroAvailable {
        self.motion.gyroUpdateInterval = 1.0 / 10.0
        self.motion.startGyroUpdates()

        // Configure a timer to fetch the accelerometer data.
        self.timer = Timer(fire: Date(), interval: (1.0/10.0),
               repeats: true, block: { (timer) in
           // Get the gyro data.
           if let data = self.motion.gyroData {
              let x = data.rotationRate.x
              let y = data.rotationRate.y
              let z = data.rotationRate.z
             
             print("x   ", x)
             print("y   ", y)
             print("z   ", z)
              // Use the gyroscope data in your app.
           }
        })

        // Add the timer to the current run loop.
       RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
     }
  }

  func stopGyros() {
     if self.timer != nil {
        self.timer?.invalidate()
        self.timer = nil

        self.motion.stopGyroUpdates()
     }
  }
}
