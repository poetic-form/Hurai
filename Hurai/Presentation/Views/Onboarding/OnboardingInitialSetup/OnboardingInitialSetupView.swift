//
//  OnboardingInitialSetupView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/7/25.
//

import SwiftUI
import FamilyControls

struct OnboardingInitialSetupView: View {
    @AppStorage("isFirst") var isFirst: Bool = true
    @State private var authStatus: AuthorizationStatus = AuthorizationCenter.shared.authorizationStatus
    @State private var notificationGranted: Bool = false
    @State private var page: Int = 0
    @State private var show: Bool = false
    
    
    var body: some View {
        VStack {
            Spacer()
            switch page {
            case 0:
                authoView()
            case 1:
                appSelectView()
            case 2:
                HuraiTimeSlider()
            case 3:
                HuraiWheelPicker(items: Array(2...60), selection: .constant(30))
            default:
                EmptyView()
            }
            
            Spacer()
            
            HStack(spacing: 50) {
                Button("이전") {
                    if page > 0 {
                        page -= 1
                    }
                }
                
                Button("다음") {
                    if page < 3 {
                        page += 1
                    } else {
                        isFirst = false
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .animation(.easeInOut(duration: 0.1), value: page)
        .onAppear {
           refreshAuthorizationStatus()
        
        }
    }
    
    @ViewBuilder
    func appSelectView() -> some View {
        VStack {
            Button("앱 고르기") {
                show = true
            }
        }
        .familyActivityPicker(isPresented: $show, selection: .constant(.init()))
    }
    
    @ViewBuilder
    func authoView() -> some View {
        VStack {
            Image(systemName: authStatus == .approved ? "checkmark.circle" : "1.circle")
                .font(.system(size: 40))
                .padding()
            
            Button("스크리타임 허용") {
                requestScreenTimeAuthorization()
            }
            
            Image(systemName: notificationGranted ? "checkmark.circle" : "2.circle")
                .font(.system(size: 40))
                .padding()
            
            Button("알림 허용") {
                requestNotificationAuthorization()
            }
            .padding()
            
            Button("알림 허용하러 가기") {
                openAppSettings()
            }
            
            Button("Revoke") {
                revoke()
            }
            .padding()
        }
    }
    
    func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func requestScreenTimeAuthorization() {
        Task {
            do {
                try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
                DispatchQueue.main.async {
                    self.authStatus = AuthorizationCenter.shared.authorizationStatus
                }
                print("스크린타임 권한 허용됨")
            } catch {
                print("스크린타임 권한 거부 또는 에러 발생: \(error)")
            }
        }
    }
    
    func revoke() {
        AuthorizationCenter.shared.revokeAuthorization { error in
            DispatchQueue.main.async {
                self.authStatus = AuthorizationCenter.shared.authorizationStatus
            }
        }
    }
    
    /// 알림 권한 요청
     func requestNotificationAuthorization() {
         UNUserNotificationCenter.current()
             .requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                 DispatchQueue.main.async {
                     self.notificationGranted = granted
                 }
             }
     }
     
     /// 현재 알림 권한 상태 확인
     func refreshAuthorizationStatus() {
         UNUserNotificationCenter.current().getNotificationSettings { settings in
             DispatchQueue.main.async {
                 self.notificationGranted = settings.authorizationStatus == .authorized
             }
         }
     }
     
}


#Preview {
    OnboardingInitialSetupView()
}

