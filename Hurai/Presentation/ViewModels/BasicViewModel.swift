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
    
    init() {
        selections = storage.selections
        threshold = storage.threshold
        startInterval = storage.startInterval
        endInterval = storage.endInterval
    }
    
    func updateSelections() {
        storage.selections = selections
    }
    
    func updateThreshold() {
        storage.threshold = threshold
    }
    
    func updateStartInterval() {
        storage.startInterval = startInterval
    }
    
    func updateEndInterval() {
        storage.endInterval = endInterval
    }
    
    func startMonitoring() {
        let threshold = DateComponents(minute: threshold)
        deviceActivityService.startMonitoring(start: startInterval, end: endInterval, apps: selections, threshold: threshold)
    }
    
    func stopMonitoring() {
        deviceActivityService.stopMonitoring(name: .activity)
    }
}
