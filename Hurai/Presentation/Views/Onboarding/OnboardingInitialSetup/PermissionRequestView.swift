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
    @State private var isPushed: Bool = false
    
    var attributedString: AttributedString {
        var string = AttributedString("후라이 사용을 위해 필요한\n두 가지 권한을 모두 허용해주세요")
        if let highlight = string.range(of: "모두 허용") {
            string[highlight].foregroundColor = .huraiAccent
        }
        return string
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text(attributedString)
                    .pretendard(.bold, 24)
                    .foregroundStyle(.white)
                    .lineSpacing(8)
                
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: viewModel.authStatus == .approved ? "checkmark" : "1.circle.fill")
                                .font(.system(size: 18))
                                .foregroundStyle(.huraiAccent)
                                .frame(width: 20, height: 20)
                            
                            Text("스크린타임")
                                .pretendard(.semibold, 16)
                                .foregroundStyle(.white)
                        }
                        
                        Text("세가지 권한을 모두 허용해야만 휴대폰 사용시간 조절을\n도와드릴 수 있어요.")
                            .pretendard(.regular, 14)
                            .foregroundStyle(.huraiGray)
                            .lineSpacing(4)
                    }
                    .padding(10)
                    
                    Divider()
                        .background(.white.opacity(0.1))
                        .padding(.horizontal, 20)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: viewModel.notificationGranted ? "checkmark" : "2.circle.fill")
                                .font(.system(size: 18))
                                .foregroundStyle(.huraiAccent)
                                .frame(width: 20, height: 20)
                            
                            Text("알림")
                                .pretendard(.semibold, 16)
                                .foregroundStyle(.white)
                        }
                        
                        Text("미션을 하려면 알림 권한 허용이 필요해요.")
                            .pretendard(.regular, 14)
                            .foregroundStyle(.huraiGray)
                            .lineSpacing(8)
                    }
                    .padding(10)
                }
            }
            .padding(20)
            
            Spacer()
            
            if viewModel.authStatus != .approved {
                HuraiButton(title: "스크린타임 권한 허용하기") {
                    requestScreenTimeAuthorization()
                }
            } else if !isPushed {
                HuraiButton(title: "알림 권한 허용하기") {
                    viewModel.requestNotificationAuthorization()
                    isPushed = true
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

