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
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("선택한 앱의\n목표 사용시간을 선택해주세요")
                        .pretendard(.bold, 24)
                        .foregroundStyle(.white)
                        .lineSpacing(8)
                    
                    Text("선택한 모든 앱의 총 목표 사용시간을 설정해주세요.")
                        .pretendard(.regular, 16)
                        .foregroundStyle(.huraiGray)
                        .lineSpacing(4)
                }
                
                Spacer()
            }
            .padding(20)
            
            Spacer().frame(height: 30)
            
            Image(.huraiAlarm)
                .resizable()
                .frame(width: 300, height: 200)
            
            Spacer()
            
            HuraiThresholdPickerView(threshold: $viewModel.threshold)
            
            Spacer()
            
            HuraiButton(title: "후라이 시작하기") {
                viewModel.showSetupView = false
                isFirst = false
            }
            .disabled(viewModel.threshold == 0)
        }
        .onChange(of: viewModel.threshold) { newValue in
            viewModel.updateThreshold()
        }
    }
}

struct HuraiThresholdPickerView: View {
    @Binding var threshold: Int
    
    var body: some View {
        HStack(spacing: 45) {
            Button {
                if threshold > 6 {
                    threshold -= 5
                } else {
                    threshold = 0
                }
            } label: {
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 65, height: 34)
                    .foregroundStyle(.huraiGray.opacity(0.18))
                    .overlay {
                       Label("5", systemImage: "minus")
                            .labelStyle(HuraiStepperLabelStyle())
                    }
            }
            .buttonStyle(.plain)
            .disabled(threshold == 0)
            
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .foregroundStyle(.gray.opacity(0.14))
                    .frame(width: 45, height: 34)
                
                HuraiWheelPicker(items: [0] + Array(2...60), selection: $threshold)
                    .overlay {
                        Text("분")
                            .pretendard(.medium, 16)
                            .foregroundStyle(.white)
                            .offset(x: 40)
                    }
                    .frame(height: 120)
                    .clipShape(Rectangle())
            }
            .frame(width: 105)
            
            Button {
                if threshold < 55 {
                    threshold += 5
                } else {
                    threshold = 60
                }
            } label: {
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 65, height: 34)
                    .foregroundStyle(.huraiGray.opacity(0.18))
                    .overlay {
                        Label("5", systemImage: "plus")
                             .labelStyle(HuraiStepperLabelStyle())
                    }
            }
            .buttonStyle(.plain)
            .disabled(threshold == 60)
        }
        .animation(.default, value: threshold)
    }
}

#Preview {
    OnboardingInitialSetupView()
        .environmentObject(OnboardingViewModel())
}

struct HuraiStepperLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 4) {
            configuration.icon
                .pretendard(.regular, 14)
            configuration.title
                .pretendard(.regular, 18)
        }
        .foregroundStyle(.white)
    }
}
