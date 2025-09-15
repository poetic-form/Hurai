//
//  HuraiRoundProgress.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/15/25.
//

import SwiftUI

struct HuraiRoundProgress : View {
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


#Preview {
//    HuraiRoundProgress()
}
