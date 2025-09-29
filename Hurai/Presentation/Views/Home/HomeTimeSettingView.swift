//
//  TimeSettingView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/18/25.
//

import SwiftUI

struct HomeTimeSettingView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Label("뒤로", systemImage: "chevron.left")
                        .pretendard(.regular, 16)
                        .foregroundStyle(.accent)
                }
                .buttonStyle(.plain)
                .disabled(viewModel.threshold == 0)
                
                Spacer()
            }
            .padding(20)
            
            VStack {
                VStack(spacing: 37) {
                    HStack {
                        Text("수면 시간")
                            .pretendard(.bold, 26)
                            .foregroundStyle(.white)
                        
                        Spacer()
                    }
                    
                    HuraiTimeSlider(startInterval: $viewModel.startInterval, endInterval: $viewModel.endInterval)
                }
                
                Divider()
                    .frame(height: 1)
                    .background(.white.opacity(0.1))
                    .padding(.vertical, 20)
                
                VStack(spacing: 20) {
                    HStack {
                        Text("오늘의 목표 시간")
                            .pretendard(.bold, 26)
                            .foregroundStyle(.white)
                        
                        Spacer()
                    }
                    
                    HuraiThresholdPickerView(threshold: $viewModel.threshold)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .background(.huraiBackground)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeTimeSettingView()
        .environmentObject(HomeViewModel())
}
