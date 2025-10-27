//
//  IntroduceView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/29/25.
//

import SwiftUI
import SafariServices

struct IntroduceView: View {
    @State private var url: URL?
    
    var attributedString: AttributedString {
        var string = AttributedString("잠들기 전 핸드폰 사용으로 수면을 방해하는 앱을 목표한 시간만큼만 사용하도록 돕는 서비스에요.")
        if let highlight = string.range(of: "수면을 방해") {
            string[highlight].foregroundColor = .accent
        }
        if let highlight = string.range(of: "목표한 시간만큼") {
            string[highlight].foregroundColor = .accent
        }
        return string
    }
    
    var body: some View {
        VStack {
            HuraiNavigationBar(title: "")
            
            ScrollView {
                VStack(spacing: 90) {
                    VStack(spacing: 40) {
                        VStack(spacing: 26) {
                            Text("당신의 수면시간 지킴이")
                                .pretendard(.medium, 18)
                                .foregroundStyle(.white)
                            
                            Text("Hurai")
                                .uhbee(40)
                                .foregroundStyle(.accent)
                        }
                        
                        Image(.huraiGuide)
                            .resizable()
                            .frame(width: 247, height: 222)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("🍳 후라이는?")
                                    .pretendard(.semibold, 20)
                                
                                Text(attributedString)
                                    .pretendard(.medium, 16)
                            }
                            
                            Divider()
                                .background(.white.opacity(0.1))
                            
                            VStack(alignment: .leading, spacing: 20) {
                                Text("이런 기능이 있어요!")
                                    .pretendard(.semibold, 20)
                                
                                VStack(alignment: .leading, spacing: 12) {
                                    Label("앱 목표 사용시간 설정", systemImage: "clock.fill")
                                    Label("목표 사용시간 알림", systemImage: "bell.fill")
                                    Label("방해 앱 잠금 & 잠금 해제 미션", systemImage: "lock.fill")
                                }
                                .labelStyle(HuraiIntroduceLabelStyle())
                            }
                        }
                        .padding(20)
                    }
                        
                    VStack(spacing: 50) {
                        Text("Hurai 메이커즈")
                            .pretendard(.semibold, 20)
                            .padding(.horizontal, 23)
                            .padding(.vertical, 10)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.white.opacity(0.06))
                            }
                        VStack(spacing: 40) {
                            HStack {
                                VStack {
                                    Image(.mac)
                                        .resizable()
                                        .frame(width: 122, height: 122)
                                    
                                    VStack(spacing: 11) {
                                        Text("이시형")
                                            .pretendard(.semibold, 16)
                                        Text("Developer")
                                            .pretendard(.medium, 12)
                                            .foregroundStyle(.white.opacity(0.7))
                                    }
                                }
                                .frame(width: 112)
                                .onTapGesture {
                                    url = URL(string: "https://github.com/poetic-form")
                                }
                               
                                VStack {
                                    Image(.dirini)
                                        .resizable()
                                        .frame(width: 122, height: 122)
                                    
                                    VStack(spacing: 11) {
                                        Text("조민")
                                            .pretendard(.semibold, 16)
                                        Text("Designer")
                                            .pretendard(.medium, 12)
                                            .foregroundStyle(.white.opacity(0.7))
                                    }
                                }
                                .frame(width: 112)
                                .onTapGesture {
                                    url = URL(string: "https://www.linkedin.com/in/himin/")
                                }
                               
                                VStack {
                                    Image(.rin)
                                        .resizable()
                                        .frame(width: 80, height: 101)
                                        .frame(height: 122)
                                    
                                    VStack(spacing: 11) {
                                        Text("김태린")
                                            .pretendard(.semibold, 16)
                                        Text("Designer")
                                            .pretendard(.medium, 12)
                                            .foregroundStyle(.white.opacity(0.7))
                                    }
                                }
                                .frame(width: 112)
                                .onTapGesture {
                                    url = URL(string: "https://www.linkedin.com/in/taerinkim-1109xftr/")
                                }
                            }
                            
                            HStack {
                                VStack {
                                    Image(.gubaab)
                                        .resizable()
                                        .frame(width: 122, height: 122)
                                    VStack(spacing: 11) {
                                        Text("임지원")
                                            .pretendard(.semibold, 16)
                                        Text("Developer")
                                            .pretendard(.medium, 12)
                                            .foregroundStyle(.white.opacity(0.7))
                                    }
                                }
                                .frame(width: 112)
                                .onTapGesture {
                                    url = URL(string: "https://github.com/baabguui")
                                }
                               
                                VStack {
                                    Image(.snooq)
                                        .resizable()
                                        .frame(width: 93, height: 87)
                                        .frame(height: 122)
                                    VStack(spacing: 11) {
                                        Text("장지아")
                                            .pretendard(.semibold, 16)
                                        Text("Developer")
                                            .pretendard(.medium, 12)
                                            .foregroundStyle(.white.opacity(0.7))
                                    }
                                }
                                .frame(width: 112)
                                .onTapGesture {
                                    url = URL(string: "https://www.linkedin.com/in/jiajang/")
                                }
                               
                                VStack {
                                    Image(.chan)
                                        .resizable()
                                        .frame(width: 132, height: 132)
                                        .frame(height: 122)
                                    VStack(spacing: 11) {
                                        Text("엄찬우")
                                            .pretendard(.semibold, 16)
                                        Text("Developer")
                                            .pretendard(.medium, 12)
                                            .foregroundStyle(.white.opacity(0.7))
                                    }
                                }
                                .frame(width: 112)
                                .onTapGesture {
                                    url = URL(string: "https://www.linkedin.com/in/찬우-엄-639a4a30a/")
                                }
                            }
                        }
                        
                        VStack(spacing: 11) {
                            Text("Apple Developer Academy@POSTECH")
                                .pretendard(.medium, 12)
                            Text("cohort 3")
                                .pretendard(.regular, 12)
                        }
                        .foregroundStyle(.white.opacity(0.6))
                        .padding(.top, 40)
                    }
                }
                .padding(20)
            }
        }
        .background(.huraiBackground)
        .navigationBarBackButtonHidden()
        .sheet(item: $url, onDismiss: { url = nil }) { URL in
            SafariView(url: URL)
        }
    }
}

#Preview {
    IntroduceView()
}

struct HuraiIntroduceLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 8) {
            configuration.icon
                .font(.system(size: 20))
                .frame(width: 20, height: 20)
                .foregroundStyle(.accent)
            configuration.title
                .foregroundStyle(.white)
                .pretendard(.medium, 16)
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {

    }
}
