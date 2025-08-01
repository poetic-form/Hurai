//
//  AppLockUseCase.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/2/25.
//

import Foundation
import FamilyControls
import ManagedSettings

class AppLockUseCase {
    let store: ManagedSettingsStore = ManagedSettingsStore()
    
    func lockApps(apps: FamilyActivitySelection) {
        store.shield.applications = apps.applicationTokens
        store.shield.webDomains = apps.webDomainTokens
    }
    
    func unlockAllApps() {
        store.shield.applications = []
        store.shield.webDomains = []
    }
}
