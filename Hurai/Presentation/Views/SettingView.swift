//
//  SettingView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/6/25.
//

import SwiftUI
import FamilyControls

struct SettingView: View {
    @EnvironmentObject var viewModel: SettingViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Binding var showMissionView: Bool
    @State var showAlert: Bool = false
    let noti: NotificationUseCase = .init()
    
    // 권한 설정같은것도 추가하면 좋겟다 세팅에
    var formatter: DateIntervalFormatter {
        let formatter = DateIntervalFormatter()
        formatter.dateStyle = .medium      // 요일까지 포함
        formatter.timeStyle = .short     // 시:분
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.locale = Locale(identifier: "ko_KR") // 한국어 설정
        return formatter
    }
    
    @AppStorage("times", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var times: TimeInterval = 1
    
    var body: some View {
        NavigationStack {
            List {
                // 이 기능 정확히 할 필요 있음
                Section(footer: Text("설명")) {
                    Toggle("잠깐 쉴래요", isOn: viewModel.isInRestModeBinding)
                }
                
                Section(header: Text("고객 지원")) {
                    NavigationLink {
                        RootView()
                    } label: {
                        Text("서비스 소개")
                    }
                    
                    NavigationLink {
                        Rectangle()
                            
                    } label: {
                        Text("오류신고 및 피드백")
                    }
                    
                    NavigationLink {
                        Circle()
                    } label: {
                        Text("개인정보처리방침")
                    }
                }
                
                Section {
                    Button("푸시알림 권한") {
                        noti.requestNotificationAuthorization()
                    }
                    
                    Button("스크린타임 권한") {
                        requestScreenTimeAuthorization()
                    }
                    
                    Button("앱 잠그기") {
                        homeViewModel.applock.lockApps(apps: homeViewModel.selections)
                    }
                    
                    Button("미션하러가기") {
                        showMissionView = true
                    }
                    
                    Button("반복 카운트 초기화 (\(Int(times - 1)))") {
                        times = 1
                    }
                    
                    Button("설정 초기화") {
                        showAlert = true
                    }
//                    
//                    NavigationLink {
//                        Text("\(homeViewModel.usecase.center.activities)")
//                    } label: {
//                        Text("모니터링중인 activities")
//                    }
                    
                    NavigationLink {
                        if let nextIntervalTime = homeViewModel.usecase.center.schedule(for: .activity)?.nextInterval {
                            Text(formatter.string(from: nextIntervalTime) ?? "error")
                        }
                    } label: {
                        Text("next interval")
                    }
                } header: {
                    Text("debuging")
                }

            }
            .alert("stop monitoring", isPresented: $showAlert) {
                Button(role: .destructive) {
                    homeViewModel.usecase.center.stopMonitoring()
                    homeViewModel.store.times = 1
                } label: {
                    Text("stop")
                }
            }
        }
    }
    
    func requestScreenTimeAuthorization() {
        Task {
            do {
                try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
                print("스크린타임 권한 허용됨")
            } catch {
                print("스크린타임 권한 거부 또는 에러 발생: \(error)")
            }
        }
    }
}

//#Preview {
//    SettingView()
//}
