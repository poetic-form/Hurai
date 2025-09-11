//
//  PermissionRequestView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/10/25.
//

import SwiftUI
import FamilyControls

struct PermissionRequestView: View {
    @Binding var page: Int
    var attributedString: AttributedString {
        var string = AttributedString("후라이 사용을 위해 필요한\n두 가지 권한을 모두 허용해주세요")
        if let highlight = string.range(of: "모두 허용") {
            string[highlight].foregroundColor = .huraiAccent
        }
        return string
    }
    
    @State private var authStatus: AuthorizationStatus = AuthorizationCenter.shared.authorizationStatus
    @State private var notificationGranted: Bool = false
    
    var body: some View {
        VStack {
            Text(attributedString)
                .pretendard(.bold, 24)
                .foregroundStyle(.huraiWhite)
           
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: authStatus == .approved ? "checkmark.circle" : "1.circle")
                        .foregroundStyle(.huraiAccent)
                    
                    Text("스크린타임")
                        .foregroundStyle(.huraiWhite)
                }
                
                Text("세가지 권한을 모두 허용해야만 휴대폰 사용시간 조절을\n도와드릴 수 있어요.")
                    .foregroundStyle(.huraiGray)
            }
            
            Divider()
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: notificationGranted ? "checkmark.circle" : "2.circle")
                        .foregroundStyle(.huraiAccent)
                    
                    Text("푸시알림")
                        .foregroundStyle(.huraiWhite)
                }
                
                Text("미션을 하려면 알림 권한 허용이 필요해요.")
                    .foregroundStyle(.huraiGray)
            }
        }
        
        Spacer()
        
        HuraiButton(title: "다음") {
            page += 1
        }
        .onAppear {
           refreshAuthorizationStatus()
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

#Preview {
    PermissionRequestView(page: .constant(0))
}
