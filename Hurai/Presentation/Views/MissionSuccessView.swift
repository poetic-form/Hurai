//
//  MissionSuccessView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/15/25.
//

import SwiftUI

struct MissionSuccessView: View {
    @EnvironmentObject var viewModel: MissionViewModel
    @Environment(\.scenePhase) private var scenePhase
    
    @AppStorage("repeatCount", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var repeatCount: TimeInterval = 0
    @AppStorage("registeredAt", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var registeredAt: Date = .now
    @AppStorage("missionState", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var missionState: Int = 0
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 100)
                
                VStack(spacing: 40) {
                    VStack(spacing: 56) {
                        Text("미션 완료")
                            .pretendard(.semibold, 16)
                            .foregroundStyle(.white.opacity(0.8))
                            .padding(.horizontal, 30)
                            .padding(.vertical, 12)
                            .background {
                                RoundedRectangle(cornerRadius: 14)
                                    .foregroundStyle(.white.opacity(0.1))
                            }
                        
                        Text("새로운 목표 사용시간을 \n설정해주세요")
                            .pretendard(.semibold, 22)
                            .foregroundStyle(.white)
                            .lineSpacing(8)
                            .multilineTextAlignment(.center)
                    }
                    
                    Image(.huraiNewAlarm)
                        .frame(width: 329, height: 185)
    
                    HuraiThresholdPickerView(threshold: $viewModel.threshold)
                        .frame(height: 100)
                }
                
              
                Spacer()
                
                HuraiButton(title: "설정 완료") {
                    missionState = 1
                    repeatCount += 1
                    viewModel.unlockApps()
                    viewModel.startMonitoring()
                    registeredAt = .now
                    MixpanelManager.shared.trackRecreateSchedule(repeatCount: Int(repeatCount))
                    viewModel.showGoBackView = true
                }
                .disabled(viewModel.threshold == 0)
            }
            
            if viewModel.showGoBackView {
                GoBackView()
            }
        }
        .background(.huraiBackground)
        .onAppear {
            viewModel.fetchAllInfos()
            MixpanelManager.shared.trackCompleteMission()
        }
        .onChange(of: viewModel.threshold) { newValue in
            viewModel.updateThreshold()
        }
        .onChange(of: scenePhase) { newValue in
            if newValue == .background && viewModel.showGoBackView {
                viewModel.showMissionView = false
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct GoBackView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.huraiBackground
                .opacity(0.75)
                
            Image(.huraiGoBack)
                .resizable()
                .frame(width: 163, height: 79)
                .padding(.leading, 18)
        }
    }
}

#Preview {
    MissionView(flipMotionService: FlipMotionService())
        .environmentObject(MissionViewModel())
}
