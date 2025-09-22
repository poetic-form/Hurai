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
    
    @State private var startAngle: Double = 0
    @State private var endAngle: Double   = 180
    @State private var startProgress: CGFloat = 0
    @State private var endProgress: CGFloat   = 0.5
    @State private var lastAngle: Double      = 0
    @State private var isClockwise: Bool      = true
    
    // MARK: - Formatter
    private var startTimeString: String {
        timeFormatter.string(from: getTime(angle: startAngle))
    }
    private var endTimeString: String {
        timeFormatter.string(from: getTime(angle: endAngle))
    }
    private var durationString: String {
        "\(getTimeDifference().0)시간 \(getTimeDifference().1)분"
    }
    private var timeFormatter: DateFormatter {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "a hh : mm"
        return f
    }
    
    let generator = UIImpactFeedbackGenerator(style: .light)
    
    // MARK: - Init
    init(startInterval: Binding<Date>, endInterval: Binding<Date>) {
        _startInterval = startInterval
        _endInterval   = endInterval
        generator.prepare()
        
        let sAngle = Self.getAngle(from: startInterval.wrappedValue)
        let eAngle = Self.getAngle(from: endInterval.wrappedValue)
        
        _startAngle   = State(initialValue: Self.normalizeAngle(sAngle))
        _endAngle     = State(initialValue: Self.normalizeAngle(eAngle))
        _startProgress = State(initialValue: Self.normalizeProgress(sAngle))
        _endProgress   = State(initialValue: Self.normalizeProgress(eAngle))
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 35) {
            HStack(spacing: 70) {
                Label(startTimeString, systemImage: "moon.zzz.fill")
                Label(endTimeString,   systemImage: "sun.max.fill")
            }
            .labelStyle(HuraiTimeLabelStyle())
            
            SleepTimeSlider()
                .padding(.bottom, 15)
        }
        .onChange(of: startTimeString) { _ in haptic() }
        .onChange(of: endTimeString)   { _ in haptic() }
    }
    
    // MARK: - Slider View
    @ViewBuilder
    func SleepTimeSlider() -> some View {
        let width: CGFloat = 253
        
        ZStack {
            // 시각 라벨
            let numbers = ["오후12시","2","4","오후6시","8","10",
                           "오전12시","2","4","오전6시","8","10"]
            ForEach(numbers.indices, id: \.self) { idx in
                Text(numbers[idx])
                    .foregroundColor(.white)
                    .pretendard(.medium, 10)
                    .rotationEffect(.degrees(Double(idx) * -30))
                    .offset(y: (width - 90) / 2)
                    .rotationEffect(.degrees(Double(idx) * 30))
            }
            
            Circle()
                .stroke(Color.white.opacity(0.06), lineWidth: 40)
                .frame(width: width, height: width)
            
            // ✅ progress 는 항상 0~1
            let reverseRotation = (startProgress > endProgress)
                ? Double((startProgress - 1) * 360) : 0
            
            Circle()
                .trim(from: startProgress > endProgress ? 0 : startProgress,
                      to: endProgress + (-reverseRotation / 360))
                .stroke(Color.accent,
                        style: StrokeStyle(lineWidth: 40,
                                           lineCap: .round,
                                           lineJoin: .round))
                .rotationEffect(.degrees(-90))
                .rotationEffect(.degrees(reverseRotation))
                .frame(width: width, height: width)
            
            // 시작 핸들
            knob(width: width,
                 systemName: "moon.zzz.fill",
                 angle: startAngle,
                 dragFromSlider: true)
            
            // 종료 핸들
            knob(width: width,
                 systemName: "sun.max.fill",
                 angle: endAngle,
                 dragFromSlider: false)
            
            HStack(spacing: 8) {
                Text(durationString)
                    .pretendard(.bold, 23)
                    .foregroundStyle(.white)
                    .monospacedDigit()
            }
        }
        .frame(width: width, height: width)
    }
    
    // MARK: - Knob View
    private func knob(width: CGFloat,
                      systemName: String,
                      angle: Double,
                      dragFromSlider: Bool) -> some View {
        Image(systemName: systemName)
            .foregroundStyle(.black)
            .font(.callout)
            .frame(width: 30, height: 30)
            .rotationEffect(.degrees(90))
            .rotationEffect(.degrees(-angle))
            .background(.white, in: Circle())
            .offset(x: width / 2)
            .rotationEffect(.degrees(angle))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        onDrag(value: value, fromSlider: dragFromSlider)
                    }
                    .onEnded { _ in
                        updateInterval()
                    }
            )
            .rotationEffect(.degrees(-90))
    }
    
    // MARK: - Drag Logic
    func onDrag(value: DragGesture.Value, fromSlider: Bool = false) {
        let vector  = CGVector(dx: value.location.x, dy: value.location.y)
        let radians = atan2(vector.dy - 15, vector.dx - 15)
        var angle   = radians * 180 / .pi
        if angle < 0 { angle += 360 }
        
        // ✅ 항상 0~360 유지
        angle = Self.normalizeAngle(angle)
        let progress = Self.normalizeProgress(angle)
        
        // 방향
        let diff = angle - lastAngle
        if abs(diff) < 180 {
            isClockwise = diff > 0
        } else {
            isClockwise = diff < 0
        }
        lastAngle = angle
        
        if fromSlider {
            let gap = abs(endAngle - angle)
            if isClockwise && (gap < 15 || gap > 345) {
                var to = angle + 15; if to > 360 { to -= 360 }
                endAngle    = Self.normalizeAngle(to)
                endProgress = Self.normalizeProgress(to)
            } else if !isClockwise && (gap < 15 || gap > 345) {
                var to = angle - 15; if to < 0 { to += 360 }
                endAngle    = Self.normalizeAngle(to)
                endProgress = Self.normalizeProgress(to)
            }
            startAngle   = angle
            startProgress = progress
        } else {
            let gap = abs(angle - startAngle)
            if !isClockwise && (gap < 15 || gap > 345) {
                var to = angle - 15; if to < 0 { to += 360 }
                startAngle   = Self.normalizeAngle(to)
                startProgress = Self.normalizeProgress(to)
            } else if isClockwise && (gap < 15 || gap > 345) {
                var to = angle + 15; if to > 360 { to -= 360 }
                startAngle   = Self.normalizeAngle(to)
                startProgress = Self.normalizeProgress(to)
            }
            endAngle   = angle
            endProgress = progress
        }
    }
    
    // MARK: - Helpers
    static func normalizeAngle(_ angle: Double) -> Double {
        let a = angle.truncatingRemainder(dividingBy: 360)
        return a < 0 ? a + 360 : a
    }
    static func normalizeProgress(_ angle: Double) -> CGFloat {
        CGFloat(normalizeAngle(angle) / 360)
    }
    
    static func getAngle(from date: Date) -> Double {
        let cal = Calendar.current
        let h = cal.component(.hour, from: date)
        let m = cal.component(.minute, from: date)
        return Double(h % 24) * 15 + Double(m) * 0.25
    }
    
    func getTime(angle: Double) -> Date {
        let p = angle / 15
        let hour = Int(p)
        let remainder = (p.truncatingRemainder(dividingBy: 1) * 12).rounded()
        var minute = remainder * 5
        minute = (minute > 55 ? 55 : minute)
        
        var comp = DateComponents()
        comp.hour   = hour == 24 ? 0 : hour
        comp.minute = Int(minute)
        comp.second = 0
        
        let cal = Calendar.current
        let now = Date()
        let day = cal.component(.day, from: now)
        let isPastMidnight = (startAngle > endAngle) && (angle == endAngle)
        comp.day   = day + (isPastMidnight ? 1 : 0)
        comp.year  = cal.component(.year, from: now)
        comp.month = cal.component(.month, from: now)
        
        return cal.date(from: comp) ?? Date()
    }
    
    func getTimeDifference() -> (Int, Int) {
        let cal = Calendar.current
        let diff = cal.dateComponents([.hour, .minute],
                        from: getTime(angle: startAngle),
                        to:   getTime(angle: endAngle))
        return (diff.hour ?? 0, diff.minute ?? 0)
    }
    
    func updateInterval() {
        startInterval = getTime(angle: startAngle)
        endInterval   = getTime(angle: endAngle)
    }
    
    func haptic() {
        generator.impactOccurred()
    }
}

// MARK: - LabelStyle
struct HuraiTimeLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 8) {
            configuration.icon
                .font(.title3)
                .foregroundStyle(.accent)
            configuration.title
                .foregroundStyle(.white)
                .pretendard(.medium, 21)
                .monospacedDigit()
        }
    }
}

#Preview {
    HuraiTimeSlider(startInterval: .constant(Date()),
                    endInterval: .constant(.now + 10000))
}
