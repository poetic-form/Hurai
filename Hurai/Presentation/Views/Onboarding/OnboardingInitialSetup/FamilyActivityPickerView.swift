//
//  FamilyActivityPickerView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/12/25.
//

import SwiftUI
import FamilyControls

struct FamilyActivityPickerView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button("취소") {
                    viewModel.cancelSelections()
                    viewModel.showFamilyActivityPickerView = false
                }
                
                Spacer()
                
                Button("다음") {
                    viewModel.updateSelections()
                    viewModel.showFamilyActivityPickerView = false
                }
                .disabled(
                    viewModel.selections.applications.count + viewModel.selections.webDomains.count > 5 ||
                    viewModel.selections.applications.count + viewModel.selections.webDomains.count == 0
                )
            }
            .padding(20)
            
            Text("최대 5개의 앱을 선택할 수 있어요.")
            
            FamilyActivityPicker(selection: $viewModel.selections)
        }
    }
}

#Preview {
    FamilyActivityPickerView()
        .environmentObject(OnboardingViewModel())
}
