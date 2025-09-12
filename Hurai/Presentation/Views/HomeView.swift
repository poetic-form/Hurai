//
//  HomeView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/6/25.
//

import SwiftUI
import FamilyControls
import ManagedSettings

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
   
    @AppStorage("registeredAt", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var registeredAt: Date = .now
    
    var body: some View {
        VStack(spacing: 10) {
            Button("앱 선택") {
                viewModel.showSelectionPicker = true
            }
            
            List {
                ForEach(Array(viewModel.selections.applicationTokens).sorted(by: { $0.rawValue < $1.rawValue} ), id: \.self) { app in
                    Label(app)
                }
                
                ForEach(Array(viewModel.selections.webDomainTokens).sorted(by: { $0.rawValue < $1.rawValue} ), id: \.self) { web in
                    Label(web)
                }
            }
            
            List {
                DatePicker("start interval", selection: $viewModel.startInterval, displayedComponents: .hourAndMinute)
                
                DatePicker("end interval", selection: $viewModel.endInterval, displayedComponents: .hourAndMinute)
                
                Picker("threshold", selection: $viewModel.threshold) {
                    ForEach(2...60, id: \.self) { index in
                        Text("\(index)분")
                            .tag(index)
                    }
                }
                .pickerStyle(.menu)
            }
            .scrollDisabled(true)
            
            Button("start monitoring") {
                viewModel.startMonitoring()
                registeredAt = .now
            }
            .buttonStyle(.bordered)
        }
        .familyActivityPicker(isPresented: $viewModel.showSelectionPicker, selection: $viewModel.selections)
        .onChange(of: viewModel.selections) { newValue in
            viewModel.updateSelections()
        }
        .onChange(of: viewModel.threshold) { newValue in
            viewModel.updateThreshold()
        }
//        .onChange(of: viewModel.startInterval) { newValue in
//            viewModel.updateStartInterval()
//        }
//        .onChange(of: viewModel.endInterval) { newValue in
//            viewModel.updateEndInterval()
//        }
        .padding()
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
