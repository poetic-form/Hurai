//
//  HuraiTimeSlider.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/8/25.
//

import SwiftUI

struct HuraiTimeSlider: View {
    @Binding var startInterval: Date
    @Binding var endInterval: Date
    
    @State var startAngle: Double = 0
    @State var endAngle: Double = 180
    @State private var startProgress: CGFloat = 0
    @State private var endProgress: CGFloat = 0.5
    @State private var lastAngle: Double = 0          // 이전 드래그 위치
    @State private var isClockwise: Bool = true       // 시계/반시계 방향 여부
    
    private var startTimeString: String {
        timeFormatter.string(from: getTime(angle: startAngle))
    }

    private var endTimeString: String {
        timeFormatter.string(from: getTime(angle: endAngle))
    }

    private var timeFormatter: DateFormatter {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "a h:mm"
        return f
    }
    
    let generator = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        VStack {
            HStack {
                Label(startTimeString, systemImage: "moon.stars.fill")
                Label(endTimeString, systemImage: "sun.max.fill")
            }
            .labelStyle(HuraiTimeLabelStyle())
            
            SleepTimeSlider()
        }
        .onAppear {
            generator.prepare()
            
            startAngle = getAngle(from: startInterval)
            startProgress = startAngle / 360
            
            endAngle = getAngle(from: endInterval)
            endProgress = endAngle / 360
        }
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
                    .stroke(Color.white.opacity(0.06), lineWidth: 10)
                
                let reverseRotation = (startProgress > endProgress) ? -Double((1 - startProgress) * 360) : 0
                
                Circle()
                    .trim(from: startProgress > endProgress ? 0 : startProgress, to: endProgress + (-reverseRotation / 360))
                    .stroke(Color.huraiAccent, style:
                                StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.init(degrees: -90))
                    .rotationEffect(.init(degrees: reverseRotation))
                
                Image(systemName: "moon.stars.fill")
                    .foregroundStyle(.black)
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
                            .onEnded { _ in
                                updateInterval()
                            }
                    )
                    .rotationEffect(.init(degrees: -90))
                
                Image(systemName: "alarm.fill")
                    .foregroundStyle(.black)
                    .font(.callout)
                    .frame(width: 30, height: 30)
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -endAngle))
                    .background(.white, in: Circle())
                    .offset(x: width / 2)
                    .rotationEffect(.init(degrees: endAngle))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                onDrag(value: value)
                            }
                            .onEnded { _ in
                                updateInterval()
                            }
                    )
                    .rotationEffect(.init(degrees: -90))
                
                HStack(spacing: 8) {
                    Text("\(getTimeDifference().0)h")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundStyle(.huraiWhite)
                    Text("\(getTimeDifference().1)m")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundStyle(.huraiWhite)
                }
            }
        }
        .frame(width: screenBounds().width / 1.6, height: screenBounds().width / 1.4)
    }
    
    func onDrag(value: DragGesture.Value, fromSlider: Bool = false) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radians = atan2(vector.dy - 15, vector.dx - 15)
        var angle = radians * 180 / .pi
        if angle < 0 { angle = 360 + angle }
        let progress = angle / 360
        
        // ✅ 방향 계산
        let diff = angle - lastAngle
        if abs(diff) < 180 {
            isClockwise = diff > 0
        } else {
            // 0°↔︎360° 경계 보정
            isClockwise = diff < 0
        }
        lastAngle = angle

        if fromSlider {
            let gap: CGFloat = abs(endAngle - angle)
            
            if isClockwise && (gap < 15 || gap > 345) {
                var toAngle = angle + 15
                if toAngle > 360 { toAngle -= 360 }
                self.endAngle = toAngle
                self.endProgress = toAngle / 360
            } else if !isClockwise && (gap < 15 || gap > 345) {
                var toAngle = angle - 15
                if toAngle > 360 { toAngle -= 360 }
                self.endAngle = toAngle
                self.endProgress = toAngle / 360
            }
            
            self.startAngle = angle
            self.startProgress = progress
        } else {
            let gap: CGFloat = abs(angle - startAngle)
            
            if !isClockwise && (gap < 15 || gap > 345) {
                var toAngle = angle - 15
                if toAngle > 360 { toAngle -= 360 }
                self.startAngle = toAngle
                self.startProgress = toAngle / 360
            } else if isClockwise && (gap < 15 || gap > 345) {
                var toAngle = angle + 15
                if toAngle > 360 { toAngle -= 360 }
                self.startAngle = toAngle
                self.startProgress = toAngle / 360
            }
            
            self.endAngle = angle
            self.endProgress = progress
        }
    }

    func getAngle(from date: Date) -> Double {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        // 1시간 = 15도, 1분 = 0.25도
        let angle = Double(hour % 24) * 15 + Double(minute) * 0.25
        return angle
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
        
        let isPastMidnight = (startAngle > endAngle) && (angle == endAngle)
        components.day = currentDay + (isPastMidnight ? 1 : 0)
        
        components.year = calendar.component(.year, from: currentDate)
        components.month = calendar.component(.month, from: currentDate)
        
        return calendar.date(from: components) ?? Date()
    }
    
    func getTimeDifference() -> (Int, Int) {
        let calendar = Calendar.current
        let result = calendar.dateComponents([.hour, .minute], from: getTime(angle: startAngle), to: getTime(angle: endAngle))
        return (result.hour ?? 0, result.minute ?? 0)
    }
    
    func updateInterval() {
        startInterval = getTime(angle: startAngle)
        endInterval = getTime(angle: endAngle)
        generator.impactOccurred()
    }
}

extension View {
    func screenBounds() -> CGRect {
        return UIScreen.main.bounds
    }
}

struct HuraiTimeLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
                .foregroundStyle(.huraiAccent)
            configuration.title
                .foregroundStyle(.white)
                .pretendard(.semibold, 18)
        }
    }
}

#Preview {
    HuraiTimeSlider(startInterval: .constant(Date()), endInterval: .constant(.now + 10000))
}
