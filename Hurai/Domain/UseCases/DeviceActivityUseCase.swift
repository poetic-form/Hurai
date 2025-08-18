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
    
    init() { }
    
    private func createSchedule(start: Date, end: Date, repeats: Bool) -> DeviceActivitySchedule {
        let calendar: Calendar = Calendar.current
        
        let intervalStart: DateComponents = calendar.dateComponents([.minute], from: start)
        let intervalEnd: DateComponents = calendar.dateComponents([.minute], from: end)
        
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
            try center.startMonitoring(.origin, during: schedule, events: events)
        } catch {
            print("Unexpected error: \(error).")
        }
    }
//    
//    func loopStartMonitoring(start: Date, end: Date, apps: FamilyActivitySelection, threshold: DateComponents) {
//        let schedule: DeviceActivitySchedule = createSchedule(start: start, end: end,  repeats: false)
//        
//        let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
//            .init("totalSelectionsUsage"): createEvent(apps: apps, threshold: threshold)
//        ]
//        
//        do {
//            try center.startMonitoring(.origin, during: schedule, events: events)
//        } catch {
//            print("Unexpected error: \(error).")
//        }
//                                                       
//    }
    
    func stopMonitoring(name: DeviceActivityName) {
        center.stopMonitoring([name])
    }
    
//    func startMonitoring(start: Date, end: Date, repeats: Bool = true, apps: FamilyActivitySelection, threshold: DateComponents) {
//        let schedule: DeviceActivitySchedule = createSchedule(start: start, end: end, repeats: repeats)
//        
//        let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
//            .init("totalSelectionsUsage"): createEvent(apps: apps, threshold: threshold)
//        ]
//        
//        do {
//            try center.startMonitoring(.init("totalSelectionsUsage"), during: schedule, events: events)
//        } catch {
//            print("Unexpected error: \(error).")
//        }
//    }
//    
//    func stopMonitoring(name: [DeviceActivityName]) {
//        center.stopMonitoring(name)
//    }

}

// 이벤트 네임, 액티비티 네임, 매니지드 세팅 스토어 네임

// origin activity 남기기 - 새로 약속하는 시점에서 loop activity 정지+추가
// loop activity는 리핏 x 설정


extension DeviceActivityName {
    static let origin = Self("origin")
    
    static let loop = Self("loop")
}
