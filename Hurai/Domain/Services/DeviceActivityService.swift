//
//  DeviceActivityUseCase.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/2/25.
//

import Foundation
import DeviceActivity
import FamilyControls

class DeviceActivityService {
    let center = DeviceActivityCenter()
    
    init() { }
    
    private func createSchedule(start: Date, end: Date, repeats: Bool) -> DeviceActivitySchedule {
        let calendar: Calendar = Calendar.current
        
        let intervalStart: DateComponents = calendar.dateComponents([.hour, .minute], from: start)
        let intervalEnd: DateComponents = calendar.dateComponents([.hour, .minute], from: end)
        
        return DeviceActivitySchedule(
            intervalStart: intervalStart,
            intervalEnd: intervalEnd,
            repeats: repeats,
            warningTime: DateComponents(minute: 1)
        )
    }
    
    private func createEvent(apps: FamilyActivitySelection, threshold: DateComponents) -> DeviceActivityEvent {
        
        return DeviceActivityEvent(
            applications: apps.applicationTokens,
            categories: apps.categoryTokens,
            webDomains: apps.webDomainTokens,
            threshold: threshold
        )
    }
    
    func originStartMonitoring(start: Date, end: Date, apps: FamilyActivitySelection, threshold: DateComponents) {
        let schedule: DeviceActivitySchedule = createSchedule(start: start, end: end, repeats: true)
        
        let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
            .init("totalSelectionsUsage"): createEvent(apps: apps, threshold: threshold)
        ]
        
        do {
            try center.startMonitoring(.activity, during: schedule, events: events)
        } catch {
            print("Unexpected error: \(error).")
        }
    }
    
    func stopMonitoring(name: DeviceActivityName) {
        center.stopMonitoring([name])
    }
}

extension DeviceActivityName {
    static let activity = Self("activity")
}
