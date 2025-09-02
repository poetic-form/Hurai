//
//  BasicViewModel.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/2/25.
//

import Foundation
import FamilyControls

class BasicViewModel: ObservableObject {
    let storage: AppInfo = .init()
    let deviceActivityService: DeviceActivityService = .init()
    let appLockService: AppLockService = .init()
    
    @Published var selections: FamilyActivitySelection
    @Published var threshold: Int
    @Published var startInterval: Date
    @Published var endInterval: Date
    @Published var registeredAt: Date
    
    init() {
        selections = storage.selections
        threshold = storage.threshold
        startInterval = storage.startInterval
        endInterval = storage.endInterval
        registeredAt = storage.registeredAt
    }
    
    func updateSelections() {
        storage.selections = selections
    }
    
    func updateThreshold() {
        storage.threshold = threshold
    }
    
    func updateInterval() {
        storage.startInterval = startInterval
        storage.endInterval = endInterval
    }
    
    func updateRegisteredAt() {
        storage.registeredAt = registeredAt
    }
    
    func startMonitoring() {
        let threshold = DateComponents(minute: threshold)
        deviceActivityService.startMonitoring(start: startInterval, end: endInterval, apps: selections, threshold: threshold)
    }
    
    func stopMonitoring() {
        deviceActivityService.stopMonitoring(name: .activity)
    }
}
