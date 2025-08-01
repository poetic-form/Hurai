//
//  DeviceActivityUseCase.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/2/25.
//

import Foundation
import DeviceActivity
import FamilyControls

class DeviceActivityUseCase {
    let center = DeviceActivityCenter()
    
    func createSchedule() -> DeviceActivitySchedule {
        let calendar: Calendar = Calendar.current
        
        let intervalStart: DateComponents = calendar.dateComponents([.hour, .minute, .weekday], from: .now)
        let intervalEnd: DateComponents = calendar.dateComponents([.hour, .minute, .weekday], from: .now.addingTimeInterval(-60))
        
        return DeviceActivitySchedule(
            intervalStart: intervalStart,
            intervalEnd: intervalEnd,
            repeats: true,
            warningTime: DateComponents(minute: 1)
        )
    }
    
    func createEvent(apps: FamilyActivitySelection, threshold: DateComponents) -> DeviceActivityEvent {
        
        return DeviceActivityEvent(
            applications: apps.applicationTokens,
            categories: apps.categoryTokens,
            webDomains: apps.webDomainTokens,
            threshold: threshold
        )
    }
    
    func startMonitoring(apps: FamilyActivitySelection, threshold: DateComponents) {
        let schedule: DeviceActivitySchedule = createSchedule()
        
        let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
            .init("totalSelectionsUsage"): createEvent(apps: apps, threshold: threshold)
        ]
        
        do {
            try center.startMonitoring(.init("totalSelectionsUsage"), during: schedule, events: events)
        } catch {
            print("Unexpected error: \(error).")
        }
    }
    
    func stopMonitoring() {
        center.stopMonitoring()
    }
}
