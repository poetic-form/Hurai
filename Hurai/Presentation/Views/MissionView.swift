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
                    RoundedRectangle(cornerRadius: 14)
                        .frame(width: 240, height: 40)
                        .foregroundStyle(.white.opacity(0.1))
                        .overlay {
                            Text("30초 동안 핸드폰 뒤집어놓기")
                                .pretendard(.semibold, 16)
                                .foregroundStyle(.white.opacity(0.8))
                        }
                    
                    Text("미션을 하는 동안 눈을 감고\n잠에 들기 위해 노력해보세요")
                        .pretendard(.semibold, 22)
                        .foregroundStyle(.white)
                        .lineSpacing(8)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                    .frame(height: 126)
                
                RoundProgressView(diameter: 220, duration: flipMotionService.requiredHoldDuration, percent: $flipMotionService.remainingDuration)
                    
                Spacer()
            }
            .onAppear {
                UIApplication.shared.isIdleTimerDisabled = true
            }
            .onDisappear {
                UIApplication.shared.isIdleTimerDisabled = false
            }
            .navigationDestination(isPresented: $viewModel.isActive) {
                SuccessView()
            }
        }
        .background(.huraiBackground)
        .onChange(of: flipMotionService.hasMetHoldRequirement) { newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    viewModel.isActive = true
                }
            }
        }
    }
}

struct SuccessView: View {
    @EnvironmentObject var viewModel: MissionViewModel
    
    @AppStorage("repeatCount", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var repeatCount: TimeInterval = 0
    @AppStorage("registeredAt", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var registeredAt: Date = .now
    
    var body: some View {
        VStack {
            Text("얼마나 더 볼건데 ?")
            
            Picker("목표 시간 설정", selection: $viewModel.threshold) {
                ForEach(2...60, id: \.self) { index in
                    Text("\(index)분").tag(index)
                }
            }
            .pickerStyle(.wheel)
            
            Button("약속하기") {
                repeatCount += 1
                viewModel.unlockApps()
                viewModel.stopMonitoring()
                viewModel.startMonitoring()
                registeredAt = .now
                viewModel.showMissionView = false
            }
        }
        .onChange(of: viewModel.threshold) { newValue in
            viewModel.updateThreshold()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MissionView(flipMotionService: FlipMotionService())
        .environmentObject(MissionViewModel())
}

struct RoundProgressView : View {
    var diameter: CGFloat
    var color: Color = .accent
    let duration: TimeInterval
    @Binding var percent: TimeInterval
    
    var body: some View {
        let lineWidth = diameter * 0.05
        let progress = (CGFloat(percent) / duration)
        
        ZStack {
            Circle()
                .stroke(Color.accent.opacity(0.2), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .frame(width: diameter, height: diameter)
            Circle()
                .trim(from: progress, to: 1)
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .frame(width: diameter, height: diameter)
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .animation(.linear, value: progress)
            
            Text("\(Int(percent.rounded(.down)))")
                .pretendard(.bold, 70)
        }
        
    }
}
