//
//  SettingView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/6/25.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var viewModel: SettingViewModel
    
    // 권한 설정같은것도 추가하면 좋겟다 세팅에
    var body: some View {
        NavigationStack {
            List {
                // 이 기능 정확히 할 필요 있음
                Section(footer: Text("설명")) {
                    Toggle("잠깐 쉴래요", isOn: viewModel.isInRestModeBinding)
                }
                
                Section(header: Text("고객 지원")) {
                    NavigationLink {
                        RootView()
                    } label: {
                        Text("서비스 소개")
                    }
                    
                    NavigationLink {
                        Rectangle()
                            
                    } label: {
                        Text("오류신고 및 피드백")
                    }
                    
                    NavigationLink {
                        Circle()
                    } label: {
                        Text("개인정보처리방침")
                    }
                }
            }
        }
    }
}

#Preview {
    SettingView()
}
