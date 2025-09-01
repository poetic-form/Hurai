//
//  MissionView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/9/25.
//

import SwiftUI

struct MissionView: View {
    @Binding var showMissionView: Bool
    @StateObject var usecase: FlipMotionUseCase
    @State var isActive: Bool = false
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            Text("\((usecase.remainingDuration.rounded()))")
                .onAppear {
                    UIApplication.shared.isIdleTimerDisabled = true
                }
                .onDisappear {
                    UIApplication.shared.isIdleTimerDisabled = false
                }
            Spacer()
                .frame(height: 100)
            
            Button("디버깅용 미션 완료 버튼") {
                isActive = true
            }
            .navigationDestination(isPresented: $isActive) {
                SuccessView(showMissionView: $showMissionView)
            }
        }
        .onChange(of: usecase.hasMetHoldRequirement) { newValue in
            if newValue {
                isActive = true
            }
        }
    }
}

struct SuccessView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @Binding var showMissionView: Bool
    @AppStorage("times", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var times: TimeInterval = 1
    
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
                times += 1
                viewModel.applock.unlockAllApps()
                viewModel.usecase.center.stopMonitoring()
                viewModel.originMonitoring()
                showMissionView = false
            }
        }
        .onChange(of: viewModel.threshold) { value in
            print(viewModel.store.times)
        }
        .onAppear {
            print(viewModel.store.times)
        }
        .navigationBarBackButtonHidden()
    }
}

//#Preview {
//    MissionView(showMissionView: .constant(true))
//}
