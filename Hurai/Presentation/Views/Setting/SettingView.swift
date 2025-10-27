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
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
    
    var body: some View {
        VStack {
            List {
                Section(footer: Text("잠깐 쉬는 동안에는 목표 사용시간을 초과해도 선택한 앱이 잠기지 않고, 설정을 변경할 수 없습니다.").pretendard(.regular, 14).foregroundStyle(.huraiLightGray).padding(.top, 14).padding(.leading, -10).padding(.bottom, 40)) {
                    Toggle(isOn: $viewModel.isOnPause) {
                        Text("잠깐 쉴래요")
                            .pretendard(.semibold, 16)
                            .padding(.vertical, 16)
                    }
                }
                .listRowInsets(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                .listRowBackground(Color.white.opacity(0.05))
                
                Section(header: Text("고객 지원").pretendard(.semibold, 16).foregroundStyle(.white.opacity(0.8)).padding(.leading, -8)) {
                    NavigationLink {
                        IntroduceView()
                    } label: {
                        Text("서비스 소개")
                            .padding(.vertical, 20)
                    }
                    
                    NavigationLink {
                        GuideView()
                    } label: {
                        Text("사용 설명서")
                            .padding(.vertical, 20)
                    }
                    
                    NavigationLink {
                        BugReportView()
                    } label: {
                        Text("오류 신고 및 피드백 남기기")
                            .padding(.vertical, 20)
                    }
                    
                    NavigationLink {
                        PrivacyPolicyView()
                    } label: {
                        Text("개인정보 처리방침")
                            .padding(.vertical, 20)
                    }
                }
                .pretendard(.regular, 16)
                .foregroundStyle(.white.opacity(0.6), .white)
                .listRowInsets(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                .listRowBackground(Color.white.opacity(0.05))
                .listRowSeparator(.hidden)
            }
            
            Text("버전 \(appVersion)")
                .pretendard(.light, 10)
                .foregroundStyle(.white.opacity(0.3))
                .padding(30)
            
            Divider()
                .background(.white.opacity(0.1))
        }
        .scrollContentBackground(.hidden)
        .scrollDisabled(true)
        .background(.huraiBackground)
        .onAppear {
            viewModel.fetchIsOnPause()
        }
        .onChange(of: viewModel.isOnPause) { newValue in
            viewModel.updateIsOnPause()
            
            if newValue {
                viewModel.stopMonitoring()
                viewModel.registNotification()
            } else {
                viewModel.startMonitoring()
                viewModel.removeNotification()
            }
        }
    }
}

#Preview {
    RootView(tag: 1)
        .environmentObject(HomeViewModel())
        .environmentObject(SettingViewModel())
        .environmentObject(MissionViewModel())
}

struct HuraiNavigationBar: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Label("뒤로", systemImage: "chevron.left")
                    .pretendard(.regular, 16)
                    .foregroundStyle(.accent)
            }
            
            Spacer()
        }
        .overlay {
            Text(title)
                .pretendard(.semibold, 16)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}
