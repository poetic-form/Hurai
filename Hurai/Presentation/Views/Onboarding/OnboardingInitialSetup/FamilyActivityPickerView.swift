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
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Button {
                    viewModel.showFamilyActivityPickerView = false
                } label: {
                    Text("취소")
                        .pretendard(.regular, 16)
                        .foregroundStyle(.huraiGray)
                }
                
                Spacer()
                
                Button {
                    viewModel.updateSelections()
                    viewModel.showFamilyActivityPickerView = false
                } label: {
                    Text("선택 완료")
                        .pretendard(.regular, 16)
                        .foregroundStyle(.accent)
                }
                .disabled(
                    viewModel.selections.applications.count + viewModel.selections.webDomains.count > 5 ||
                    viewModel.selections.applications.count + viewModel.selections.webDomains.count == 0
                )
            }
            .padding(20)
            
            Text("최대 5개의 앱을 선택할 수 있어요.")
                .pretendard(.regular, 16)
                .foregroundStyle(.huraiGray)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            
            FamilyActivityPicker(selection: $viewModel.selections)
        }
        .background(.huraiBackground)
    }
}

#Preview {
    FamilyActivityPickerView()
        .environmentObject(OnboardingViewModel())
}
