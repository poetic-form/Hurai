//
//  MissionView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/9/25.
//

import SwiftUI

struct MissionView: View {
    @Binding var showMissionView: Bool
    @StateObject var usecase: FlipMotionUseCase = .init(requiredHoldDuration: 3)
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("\((usecase.remainingDuration.rounded()))")
            
            Button("성공") {
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
    
    var body: some View {
        VStack {
            Text("얼마나 더 볼건데 ?")
            
            Picker("목표 시간 설정", selection: viewModel.thresholdBinding) {
                ForEach(0...10, id: \.self) { index in
                    Text("\(index)분")
                }
            }
            .pickerStyle(.wheel)
            
            Button("약속하기") {
                viewModel.applock.unlockAllApps()
                viewModel.originMonitoring()
                showMissionView = false
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MissionView(showMissionView: .constant(true))
}
