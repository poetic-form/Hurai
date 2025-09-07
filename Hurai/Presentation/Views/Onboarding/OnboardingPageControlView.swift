//
//  OnboardingPageControlView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/7/25.
//

import SwiftUI

struct OnboardingPageControlView: View {
    @State private var currentPage: Int = 0
    @AppStorage("isFirst") var isFirst: Bool = true

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                Rectangle()
                    .foregroundStyle(.red)
                    .opacity(0.7)
                    .tag(0)
                
                Rectangle()
                    .foregroundStyle(.blue)
                    .opacity(0.7)
                    .tag(1)
                
                Rectangle()
                    .foregroundStyle(.green)
                    .opacity(0.7)
                    .tag(2)
                
                Rectangle()
                    .foregroundStyle(.purple)
                    .opacity(0.7)
                    .tag(3)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            PageControlIndicator(count: 4, currentPage: $currentPage)
            
            HuraiButton(title: "다음") {
                currentPage += 1
                
                if currentPage > 3 {
                    isFirst = false
                }
            }
        }
        .background(.black)
    }
}

struct PageControlIndicator: View {
    let count: Int
    @Binding var currentPage: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0...count - 1, id: \.self) { index in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(.yellow)
                    .opacity(index == currentPage ? 1 : 0.3)
                    .onTapGesture {
                        if index > currentPage {
                            withAnimation {
                                currentPage += 1
                            }
                        } else if index < currentPage {
                            withAnimation {
                                currentPage -= 1
                            }
                        }
                    }
                    .animation(.easeInOut, value: currentPage)
            }
        }
    }
}

#Preview {
    OnboardingPageControlView()
}
