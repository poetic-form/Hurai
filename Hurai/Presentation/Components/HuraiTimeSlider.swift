//
//  HuraiTimeSlider.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/8/25.
//

import SwiftUI

struct HuraiTimeSlider: View {
    @State var startAngle: Double = 0
    @State var toAngle: Double = 180
    @State private var startProgress: CGFloat = 0
    @State private var toProgress: CGFloat = 0.5
    
    var body: some View {
        SleepTimeSlider()
    }
    
    @ViewBuilder
    func SleepTimeSlider() -> some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            ZStack {
                ZStack {
                    let numbers = [12, 15, 18, 21, 0, 3, 6, 9]
                    
                    ForEach(numbers.indices, id: \.self) { index in
                        Text("\(numbers[index])")
                            .foregroundColor(.secondary)
                            .font(.caption)
                            .rotationEffect(.init(degrees: Double(index) * -45))
                            .offset(y: (width - 90) / 2)
                            .rotationEffect(.init(degrees: Double(index) * 45 ))
                    }
                }
                
                Circle()
                    .stroke(Color.black.opacity(0.06), lineWidth: 40)
                
                let reverseRotation = (startProgress > toProgress) ? -Double((1 - startProgress) * 360) : 0
                
                Circle()
                    .trim(from: startProgress > toProgress ? 0 : startProgress, to: toProgress + (-reverseRotation / 360))
                    .stroke(Color.black, style:
                                StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.init(degrees: -90))
                    .rotationEffect(.init(degrees: reverseRotation))
                
                Image(systemName: "moon.stars.fill")
                    .font(.callout)
                    .frame(width: 30, height: 30)
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -startAngle))
                    .background(.white, in: Circle())
                    .offset(x: width / 2)
                    .rotationEffect(.init(degrees: startAngle))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                onDrag(value: value, fromSlider: true)
                            }
                    )
                    .rotationEffect(.init(degrees: -90))
                
                Image(systemName: "alarm.fill")
                    .font(.callout)
                    .frame(width: 30, height: 30)
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -toAngle))
                    .background(.white, in: Circle())
                    .offset(x: width / 2)
                    .rotationEffect(.init(degrees: toAngle))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                onDrag(value: value)
                            }
                    )
                    .rotationEffect(.init(degrees: -90))
                
                HStack(spacing: 8) {
                    Text("\(getTimeDifference().0)h")
                        .font(.title)
                        .fontWeight(.medium)
                    Text("\(getTimeDifference().1)m")
                        .font(.title)
                        .fontWeight(.medium)
                }
            }
        }
        .frame(width: screenBounds().width / 1.6, height: screenBounds().width / 1.4)
    }
    
    func onDrag(value: DragGesture.Value, fromSlider: Bool = false) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radians = atan2(vector.dy - 15, vector.dx - 15)
        var angle = radians * 180 / .pi
//        if angle < 0 { angle = 360 + angle }
        var progress = angle / 360
        if progress < 0 { progress = 1 + progress }
        if fromSlider {
            if abs(angle - toAngle) > 30 {
                self.startAngle = angle
                self.startProgress = progress
            }
        } else {
            if abs(angle - startAngle) > 30 {
                self.toAngle = angle
                self.toProgress = progress
            }
        }
    }
    
    func getTime(angle: Double) -> Date {
        let progress = angle / 15
        let hour = Int(progress)
        let remainder = (progress.truncatingRemainder(dividingBy: 1) * 12).rounded()
        var minute = remainder * 5
        minute = (minute > 55 ? 55 : minute)
        
        var components = DateComponents()
        components.hour = hour == 24 ? 0 : hour
        components.minute = Int(minute)
        components.second = 0
        
        let calendar = Calendar.current
        let currentDate = Date()
        let currentDay = calendar.component(.day, from: currentDate)
        
        let isPastMidnight = (startAngle > toAngle) && (angle == toAngle)
        components.day = currentDay + (isPastMidnight ? 1 : 0)
        
        components.year = calendar.component(.year, from: currentDate)
        components.month = calendar.component(.month, from: currentDate)
        
        return calendar.date(from: components) ?? Date()
    }
    
    func getTimeDifference() -> (Int, Int) {
        let calendar = Calendar.current
        let result = calendar.dateComponents([.hour, .minute], from: getTime(angle: startAngle), to: getTime(angle: toAngle))
        return (result.hour ?? 0, result.minute ?? 0)
    }
}

extension View {
    func screenBounds() -> CGRect {
        return UIScreen.main.bounds
    }
}

#Preview {
    HuraiTimeSlider()
}
