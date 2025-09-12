//
//  MissionView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/9/25.
//

import SwiftUI

struct MissionView: View {
    @EnvironmentObject var viewModel: MissionViewModel
    @StateObject var flipMotionService: FlipMotionService
    
    var body: some View {
        NavigationStack {
            Text("\((flipMotionService.remainingDuration.rounded()))")
                .onAppear {
                    UIApplication.shared.isIdleTimerDisabled = true
                }
                .onDisappear {
                    UIApplication.shared.isIdleTimerDisabled = false
                }
            Spacer()
                .frame(height: 100)
            
            Button("디버깅용 미션 완료 버튼") {
                viewModel.isActive = true
            }
            .navigationDestination(isPresented: $viewModel.isActive) {
                SuccessView()
            }
        }
        .onChange(of: flipMotionService.hasMetHoldRequirement) { newValue in
            if newValue {
                viewModel.isActive = true
            }
        }
    }
}

struct SuccessView: View {
    @EnvironmentObject var viewModel: MissionViewModel
    
    @AppStorage("repeatCount", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var repeatCount: TimeInterval = 0
    @AppStorage("registeredAt", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var registeredAt: Date = .now
    
    var body: some View {
        VStack {
            Text("얼마나 더 볼건데 ?")
            
            Picker("목표 시간 설정", selection: $viewModel.threshold) {
                ForEach(2...60, id: \.self) { index in
                    Text("\(index)분").tag(index)
                }
            }
            .pickerStyle(.wheel)
            
            Button("약속하기") {
                repeatCount += 1
                viewModel.unlockApps()
                viewModel.stopMonitoring()
                viewModel.startMonitoring()
                registeredAt = .now
                viewModel.showMissionView = false
            }
        }
        .onChange(of: viewModel.threshold) { newValue in
            viewModel.updateThreshold()
        }
        .navigationBarBackButtonHidden()
    }
}

//#Preview {
//    MissionView(showMissionView: .constant(true))
//}
