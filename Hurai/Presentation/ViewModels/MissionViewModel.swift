//
//  MissionViewModel.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/2/25.
//

import Foundation

class MissionViewModel: BasicViewModel {
    let appLockService: AppLockService = AppLockService()
    @Published var showMissionView: Bool = false
    @Published var isActive: Bool = false
    @Published var showGoBackView: Bool = false
    
    func unlockApps() {
        appLockService.unlockAllApps()
    }
    
    func initialize() {
        showMissionView = true
        isActive = false
        showGoBackView = false
    }
}
