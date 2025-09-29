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
    
    @Published var selections: FamilyActivitySelection
    @Published var threshold: Int
    @Published var startInterval: Date
    @Published var endInterval: Date
    @Published var isOnPause: Bool
    
    init() {
        selections = storage.selections
        threshold = storage.threshold
        startInterval = storage.startInterval
        endInterval = storage.endInterval
        isOnPause = storage.isOnPause
    }
    
    func updateSelections() {
        storage.selections = selections
    }
    
    func fetchSelections() {
        selections = storage.selections
    }
    
    func updateThreshold() {
        storage.threshold = threshold
    }
    
    func fetchThreshold() {
        threshold = storage.threshold
    }
    
    func updateInterval() {
        storage.startInterval = startInterval
        storage.endInterval = endInterval
    }
    
    func fetchInterval() {
        startInterval = storage.startInterval
        endInterval = storage.endInterval
    }
    
    func fetchIsOnPause() {
        isOnPause = storage.isOnPause
    }
    
    func updateIsOnPause() {
        storage.isOnPause = isOnPause
    }
    
    func updateAllInfos() {
        updateInterval()
        updateThreshold()
        updateSelections()
    }
    
    func fetchAllInfos() {
        fetchInterval()
        fetchThreshold()
        fetchSelections()
    }
    
    func startMonitoring() {
        let threshold = DateComponents(minute: threshold)
        deviceActivityService.startMonitoring(start: startInterval, end: endInterval, apps: selections, threshold: threshold)
    }
    
    func stopMonitoring() {
        deviceActivityService.stopMonitoring(name: .activity)
    }
}
