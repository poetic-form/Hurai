//
//  OnboardingInitialSetupViewModel.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/9/25.
//

import Foundation
import FamilyControls
import UserNotifications

class OnboardingViewModel: ObservableObject {
    @Published var onboardingPage: Int = 0
    @Published var setupPage: Int = 0
    @Published var showSetupView: Bool = false
    
    @Published var authStatus: AuthorizationStatus = AuthorizationCenter.shared.authorizationStatus
    @Published var notificationGranted: Bool = false
    
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                DispatchQueue.main.async {
                    self.notificationGranted = granted
                }
            }
    }
    
    func refreshAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.notificationGranted = settings.authorizationStatus == .authorized
            }
        }
    }
}
