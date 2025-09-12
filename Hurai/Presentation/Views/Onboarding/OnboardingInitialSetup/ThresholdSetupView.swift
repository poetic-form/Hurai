//
//  ThresholdSetupView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/10/25.
//

import SwiftUI

struct ThresholdSetupView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @AppStorage("isFirst") var isFirst: Bool = true
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("선택한 앱의\n목표 사용시간을 선택해주세요")
                    .pretendard(.bold, 24)
                    .foregroundStyle(.huraiWhite)
                
                Text("선택한 모든 앱의 총 목표 사용시간을 설정해주세요.\n최소 2분부터 최대 60분까지 설정할 수 있어요. ")
                    .pretendard(.regular, 16)
                    .foregroundStyle(.huraiGray)
            }
            
            Spacer().frame(height: 70)
            
            Rectangle()
                .frame(width: 150, height: 150)
                .foregroundStyle(.gray)
            
            Spacer()
            
            HuraiThresholdPickerView(threshold: $viewModel.threshold)
            
            Spacer()
            
            HuraiButton(title: "다음") {
                isFirst = false
            }
        }
        .onChange(of: viewModel.threshold) { newValue in
            viewModel.updateThreshold()
        }
    }
}

struct HuraiThresholdPickerView: View {
    @Binding var threshold: Int
    
    var body: some View {
        HStack(spacing: 55) {
            Button {
                if threshold > 7 {
                    threshold -= 5
                } else {
                    threshold = 2
                }
            } label: {
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 65, height: 34)
                    .foregroundStyle(.huraiGray.opacity(0.18))
                    .overlay {
                        Text("- 5")
                            .pretendard(.regular, 18)
                            .foregroundStyle(.white)
                    }
            }
            .buttonStyle(.plain)
            .disabled(threshold == 2)
            
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .foregroundStyle(.gray.opacity(0.14))
                    .frame(width: 45, height: 34)
                
                HuraiWheelPicker(items: Array(2...60), selection: $threshold)
                    .overlay {
                        Text("분")
                            .pretendard(.medium, 16)
                            .foregroundStyle(.white)
                            .offset(x: 40)
                    }
            }
            .frame(width: 85)
            
            Button {
                if threshold < 55{
                    threshold += 5
                } else {
                    threshold = 60
                }
            } label: {
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 65, height: 34)
                    .foregroundStyle(.huraiGray.opacity(0.18))
                    .overlay {
                        Text("+ 5")
                            .pretendard(.regular, 18)
                            .foregroundStyle(.white)
                    }
            }
            .buttonStyle(.plain)
            .disabled(threshold == 60)
        }
        .animation(.default, value: threshold)
    }
}

#Preview {
    ThresholdSetupView()
        .environmentObject(OnboardingViewModel())
}

