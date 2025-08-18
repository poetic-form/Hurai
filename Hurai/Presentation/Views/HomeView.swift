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
            
            Text(viewModel.threshold.description)
            
            DatePicker("시작", selection: $viewModel.startInderval, displayedComponents: .hourAndMinute)
            
            DatePicker("끝", selection: $viewModel.endInderval, displayedComponents: .hourAndMinute)
            
            Button("목표 시간 설정") {
                viewModel.showThresholdPicker = true
            }
            
            Text("\(String(describing: viewModel.usecase.center.schedule(for: .origin)?.nextInterval))")
            Text("\(viewModel.usecase.center.activities)")
            
            Button("측정 시작") {
                viewModel.originMonitoring()
            }
            
            Button("측정 종료") {
                viewModel.usecase.stopMonitoring(name: .init("totalSelectionsUsage"))
            }
        }
        .familyActivityPicker(isPresented: $viewModel.showSelectionPicker, selection: viewModel.selectionsBinding)
        .sheet(isPresented: $viewModel.showThresholdPicker) {
            ThresholdPickerView()
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
