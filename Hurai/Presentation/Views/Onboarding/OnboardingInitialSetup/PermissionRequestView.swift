//
//  PermissionRequestView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/10/25.
//

import SwiftUI
import FamilyControls

struct PermissionRequestView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var attributedString: AttributedString {
        var string = AttributedString("후라이 사용을 위해 필요한\n두 가지 권한을 모두 허용해주세요")
        if let highlight = string.range(of: "모두 허용") {
            string[highlight].foregroundColor = .huraiAccent
        }
        return string
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 20) {
                Text(attributedString)
                    .pretendard(.bold, 24)
                    .foregroundStyle(.huraiWhite)
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: viewModel.authStatus == .approved ? "checkmark" : "1.circle.fill")
                            .foregroundStyle(.huraiAccent)
                        
                        Text("스크린타임")
                            .foregroundStyle(.huraiWhite)
                    }
                    
                    Text("세가지 권한을 모두 허용해야만 휴대폰 사용시간 조절을\n도와드릴 수 있어요.")
                        .pretendard(.regular, 14)
                        .foregroundStyle(.huraiGray)
                }
                
                Divider()
                    .background(.huraiGray)
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: viewModel.notificationGranted ? "checkmark" : "2.circle.fill")
                            .foregroundStyle(.huraiAccent)
                        
                        Text("푸시알림")
                            .foregroundStyle(.huraiWhite)
                    }
                    
                    Text("미션을 하려면 알림 권한 허용이 필요해요.")
                        .pretendard(.regular, 14)
                        .foregroundStyle(.huraiGray)
                }
            }
            .padding(20)
            
            Spacer()
            
            if viewModel.authStatus != .approved {
                HuraiButton(title: "스크린타임 권한 허용하기") {
                    requestScreenTimeAuthorization()
                }
            } else if viewModel.notificationGranted == false {
                HuraiButton(title: "알림 권한 허용하기") {
                    viewModel.requestNotificationAuthorization()
                }
            } else {
                HuraiButton(title: "다음") {
                    viewModel.setupPage += 1
                }
            }
        }
        .onAppear {
            viewModel.refreshAuthorizationStatus()
        }
    }
    
    func requestScreenTimeAuthorization() {
        Task {
            do {
                try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
                DispatchQueue.main.async {
                    viewModel.authStatus = AuthorizationCenter.shared.authorizationStatus
                }
                print("스크린타임 권한 허용됨")
            } catch {
                print("스크린타임 권한 거부 또는 에러 발생: \(error)")
            }
        }
    }
}

#Preview {
    OnboardingInitialSetupView()
        .environmentObject(OnboardingViewModel())
}

