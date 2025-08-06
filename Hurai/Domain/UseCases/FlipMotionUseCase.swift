//
//  FlipMotionUseCase.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/6/25.
//

import Foundation
import CoreMotion

class FlipMotionUseCase: ObservableObject {
    let requiredHoldDuration: TimeInterval
    
    private let motionManager = CMMotionManager()
    private var timer: Timer?
    private var holdStartTime: Date?
    private var accumulatedHoldDuration: TimeInterval = 0
    
    @Published var isFlipped: Bool = false
    @Published var totalHeldDuration: TimeInterval = 0
    @Published var remainingDuration: TimeInterval = 0
    @Published var hasMetHoldRequirement: Bool = false

    init(requiredHoldDuration: TimeInterval = 10) {
        self.requiredHoldDuration = requiredHoldDuration
        self.remainingDuration = requiredHoldDuration
        startMonitoring()
    }
    
    private func startMonitoring() {
        guard motionManager.isDeviceMotionAvailable else {
            print("Device motion not available")
            return
        }
        
        motionManager.deviceMotionUpdateInterval = 0.2
        
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, _ in
            guard let self, let motion else { return }
            
            let z = motion.gravity.z
            
            if z > 0.9 { // Fully flipped
                if !self.isFlipped {
                    self.isFlipped = true
                    self.holdStartTime = Date()
                    self.startTimer()
                    print("🔄 뒤집힘 시작")
                }
            } else {
                if self.isFlipped {
                    self.isFlipped = false
                    self.stopAndAccumulateHoldTime()
                    self.stopTimer()
                    print("↩️ 원래대로 돌아옴")
                }
            }
        }
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { [weak self] _ in
            self?.updateHoldTime()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func stopAndAccumulateHoldTime() {
        guard let start = holdStartTime else { return }
        let duration = Date().timeIntervalSince(start)
        accumulatedHoldDuration += duration
        totalHeldDuration = accumulatedHoldDuration
        holdStartTime = nil
        updateRemainingTime()
    }
    
    private func updateHoldTime() {
        guard isFlipped, let start = holdStartTime else { return }
        let currentHold = Date().timeIntervalSince(start)
        let total = accumulatedHoldDuration + currentHold
        totalHeldDuration = total
        updateRemainingTime()
        
        print("⏱️ 누적 유지 시간: \(Int(total))초 (남은 시간: \(Int(remainingDuration))초)")
        
        if total >= requiredHoldDuration {
            hasMetHoldRequirement = true
            stopTimer()
            print("✅ 목표 시간 \(Int(requiredHoldDuration))초 도달!")
        }
    }
    
    private func updateRemainingTime() {
        let remaining = max(0, requiredHoldDuration - totalHeldDuration)
        remainingDuration = remaining
    }
    
    deinit {
        motionManager.stopDeviceMotionUpdates()
        stopTimer()
    }
}
