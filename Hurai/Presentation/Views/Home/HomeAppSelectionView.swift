//
//  HomeAppSelectionView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/18/25.
//

import SwiftUI
import FamilyControls

struct HomeAppSelectionView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Label("뒤로", systemImage: "chevron.left")
                        .pretendard(.regular, 16)
                        .foregroundStyle(.accent)
                }
                
                Spacer()
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
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeAppSelectionView()
        .environmentObject(HomeViewModel())
}
