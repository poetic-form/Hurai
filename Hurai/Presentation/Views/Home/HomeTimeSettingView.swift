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
        VStack(spacing: 10) {
            HStack {
                Button {
                    viewModel.fetchInterval()
                    viewModel.fetchThreshold()
                    dismiss()
                } label: {
                    Text("취소")
                        .pretendard(.regular, 16)
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                Button {
                    viewModel.updateInterval()
                    viewModel.updateThreshold()
                    dismiss()
                } label: {
                    Text("확인")
                        .pretendard(.regular, 16)
                        .foregroundStyle(.accent)
                }
            }
            .padding(20)
            
            VStack(spacing: 65) {
                VStack {
                    HStack {
                        Text("수면 시간")
                            .pretendard(.semibold, 20)
                            .foregroundStyle(.white)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                    
                    HuraiTimeSlider(startInterval: $viewModel.startInterval, endInterval: $viewModel.endInterval)
                }
                
                VStack {
                    HStack {
                        Text("오늘의 목표 시간")
                            .pretendard(.semibold, 20)
                            .foregroundStyle(.white)
                        
                        Spacer()
                    }
                    .padding(20)
                    
                    HuraiThresholdPickerView(threshold: $viewModel.threshold)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeTimeSettingView()
        .environmentObject(HomeViewModel())
}
