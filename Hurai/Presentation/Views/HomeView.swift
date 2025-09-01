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
    @State var showAlert: Bool = false
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
                viewModel.usecase.center.stopMonitoring()
                viewModel.originMonitoring()
                showAlert = true
            }
            .buttonStyle(.bordered)
        }
        .familyActivityPicker(isPresented: $viewModel.showSelectionPicker, selection: viewModel.selectionsBinding)
        .sheet(isPresented: $viewModel.showThresholdPicker) {
            ThresholdPickerView()
                .environmentObject(viewModel)
        }
        .alert("start monitoring", isPresented: $showAlert, actions: {
            Button("OK") {
                showAlert = false
            }
        })
        .padding()
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}

extension Token: @retroactive RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(Token.self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
