//
//  MissionView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/9/25.
//

import SwiftUI

struct MissionView: View {
    @EnvironmentObject var viewModel: MissionViewModel
    @StateObject var flipMotionService: FlipMotionService
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                    .frame(height: 100)
                
                VStack(spacing: 56) {
                    Text("30초 동안 핸드폰 뒤집어놓기")
                        .pretendard(.semibold, 16)
                        .foregroundStyle(.white.opacity(0.8))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background {
                            RoundedRectangle(cornerRadius: 14)
                                .foregroundStyle(.white.opacity(0.1))
                        }

                    Text("미션을 하는 동안 눈을 감고\n잠에 들기 위해 노력해보세요")
                        .pretendard(.semibold, 22)
                        .foregroundStyle(.white)
                        .lineSpacing(8)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                    .frame(height: 126)
                
                HuraiRoundProgress(diameter: 220, duration: flipMotionService.requiredHoldDuration, percent: $flipMotionService.remainingDuration)
                    
                Spacer()
            }
            .onAppear {
                UIApplication.shared.isIdleTimerDisabled = true
            }
            .onDisappear {
                UIApplication.shared.isIdleTimerDisabled = false
            }
            .navigationDestination(isPresented: $viewModel.isActive) {
                MissionSuccessView()
            }
        }
        .background(.huraiBackground)
        .onAppear {
            viewModel.initialize()
        }
        .onChange(of: flipMotionService.hasMetHoldRequirement) { newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    viewModel.isActive = true
                }
            }
        }
    }
}



#Preview {
    MissionView(flipMotionService: FlipMotionService())
        .environmentObject(MissionViewModel())
        .background(.huraiBackground)
}
