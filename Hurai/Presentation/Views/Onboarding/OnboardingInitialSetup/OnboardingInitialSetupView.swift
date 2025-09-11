//
//  OnboardingInitialSetupView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/7/25.
//

import SwiftUI
import FamilyControls

struct OnboardingInitialSetupView: View {
    @AppStorage("isFirst") var isFirst: Bool = true

    @State private var page: Int = 0
    @State private var show: Bool = false
    
    
    var body: some View {
        VStack {
            Button("뒤로가기") {
                page -= 1
            }
            .disabled(page == 0)
            
            HStack(spacing: 20) {
                ForEach(0...3, id: \.self) { index in
                    if index <= page {
                        RoundedRectangle(cornerRadius: 100)
                            .frame(width: 75, height: 6)
                            .foregroundStyle(.huraiAccent)
                    } else {
                        RoundedRectangle(cornerRadius: 100)
                            .frame(width: 75, height: 6)
                            .foregroundStyle(.white.opacity(0.1))
                    }
                }
            }
            .padding(20)
            
            switch page {
            case 0:
                PermissionRequestView(page: $page)
            case 1:
                AppSelectionView(page: $page)
            case 2:
                ScheduleSetupView(page: $page)
            case 3:
                ThresholdSetupView(page: $page)
            default:
                EmptyView()
            }
        }
        .background(.huraiBackground)
        .navigationBarBackButtonHidden()
        .animation(.easeInOut(duration: 0.1), value: page)
    }
}


#Preview {
    OnboardingInitialSetupView()
}

