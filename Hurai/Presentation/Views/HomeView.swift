//
//  HomeView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/6/25.
//

import SwiftUI
import FamilyControls

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 50) {
            Button("앱 선택") {
                viewModel.showSelectionPicker = true
            }
            
            List {
                ForEach(Array(viewModel.selections.applicationTokens), id: \.self) { app in
                    Label(app)
                }
                
                ForEach(Array(viewModel.selections.webDomainTokens), id: \.self) { web in
                    Label(web)
                }
            }
            .frame(height: 300)
            
            Text(viewModel.threshold.description)
            
            Button("목표 시간 설정") {
                viewModel.showThresholdPicker = true
            }
            
            Button("측정 시작") {
                viewModel.action()
            }
            
            Button("미션뷰") {
                viewModel.showMissionView = true
            }
        }
        .familyActivityPicker(isPresented: $viewModel.showSelectionPicker, selection: viewModel.selectionsBinding)
        .sheet(isPresented: $viewModel.showThresholdPicker) {
            ThresholdPickerView()
                .environmentObject(viewModel)
        }
        .fullScreenCover(isPresented: $viewModel.showMissionView) {
            Button("닫기") {
                viewModel.showMissionView = false
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
