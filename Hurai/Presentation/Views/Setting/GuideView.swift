//
//  GuideView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/29/25.
//

import SwiftUI

struct GuideView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Label("뒤로", systemImage: "chevron.left")
                        .pretendard(.regular, 16)
                        .foregroundStyle(.accent)
                }
                
                Spacer()
            }
            .overlay {
                Text("사용 설명서")
                    .pretendard(.semibold, 16)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("🍳 후라이 스토리")
                            .pretendard(.bold, 16)
                            .foregroundStyle(.accent)
                        
                        Text("후라이는 잠들기 전 핸드폰 사용으로 자꾸만 수면시간이 줄어드는 사람들을 위해 만들었어요.\n\n이러한 문제를 해결하기 위해서 이 문제에 공감하는 6명의 애플 디벨로퍼 아카데미 러너들이 모여 함께 제작한 서비스에요.".byCharWrapping)
                            .pretendard(.medium, 16)
                            .foregroundStyle(.white)
                    }
                    .padding(20)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.white.opacity(0.1))
                    }
                    
                    VStack(alignment: .leading, spacing: 24) {
                        Text("💡 후라이 사용법")
                            .pretendard(.bold, 16)
                            .foregroundStyle(.accent)
                        
                        VStack(alignment: .leading, spacing: 30) {
                            VStack(alignment: .leading, spacing: 12) {
                                Label {
                                    Text("내가 잠들기 전에 자주 하는 앱들을 선택해주세요.")
                                } icon: {
                                    Text("1.")
                                }
                                .pretendard(.semibold, 16)
                                Label {
                                    Text("앱은 최대 5개까지 선택할 수 있어요. 나의 수면을 가장 많이 방해하고 있는 앱들을 선택해주세요.".byCharWrapping)
                                } icon: {
                                    Text("•")
                                }
                                .pretendard(.medium, 14)
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Label {
                                    Text("평소 나의 수면시간을 선택해주세요.")
                                } icon: {
                                    Text("2.")
                                }
                                .pretendard(.semibold, 16)
                                Label {
                                    Text("최소 1시간 이상의 차이가 필요해요.")
                                } icon: {
                                    Text("•")
                                }
                                .pretendard(.medium, 14)
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Label {
                                    Text("선택한 최대 5가지의 앱의 총 목표 사용시간을 선택해주세요.".byCharWrapping)
                                } icon: {
                                    Text("3.")
                                }
                                .pretendard(.semibold, 16)
                                
                                Label {
                                    Text("2분부터 최대 1시간까지 설정이 가능해요.")
                                } icon: {
                                    Text("•")
                                }
                                .pretendard(.medium, 14)
                                
                                Label {
                                    Text("예를 들어, 인스타그램과 유튜브를 선택했고 총 1시간을 사용하겠다고 선택했다면 인스타그램과 유튜브 사용시간을 합쳐서 1시간이 되었을 때 후라이가 알려드려요.".byCharWrapping)
                                } icon: {
                                    Text("•")
                                }
                                .pretendard(.medium, 14)
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Label {
                                    Text("그리고 목표한 시간이 모두 지나면 후라이가 알림을 보내요.".byCharWrapping)
                                } icon: {
                                    Text("4.")
                                }
                                .pretendard(.semibold, 16)
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Label {
                                    Text("일정 시간 동안 핸드폰을 뒤집어주세요.".byCharWrapping)
                                } icon: {
                                    Text("5.")
                                }
                                .pretendard(.semibold, 16)
                                
                                Label {
                                    Text("핸드폰을 뒤집고 미션을 진행하는 동안 잠들기 위해 노력해보세요.".byCharWrapping)
                                } icon: {
                                    Text("•")
                                }
                                .pretendard(.medium, 14)
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Label {
                                    Text("미션을 진행한 후, 핸드폰을 더 사용하고 싶다면 목표 사용시간을 다시 설정해주세요.".byCharWrapping)
                                } icon: {
                                    Text("6.")
                                }
                                .pretendard(.semibold, 16)
                                
                                Label {
                                    Text("목표 사용시간을 다시 설정하면 병아리가 깨어나지 못하고 후라이가 돼요..".byCharWrapping)
                                } icon: {
                                    Text("•")
                                }
                                .pretendard(.medium, 14)
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Label {
                                    Text("다시 목표 사용시간만큼 사용했다면 후라이가 알림을 보내요.".byCharWrapping)
                                } icon: {
                                    Text("7.")
                                }
                                .pretendard(.semibold, 16)
                                
                                Label {
                                    Text("다시 한번 미션을 진행하며 잠들기 위해 노력해보세요.".byCharWrapping)
                                } icon: {
                                    Text("•")
                                }
                                .pretendard(.medium, 14)
                            }
                        }
                    }
                    .padding(20)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.white.opacity(0.1))
                    }
                    
                    VStack(alignment: .leading, spacing: 24) {
                        Text("❓ 그 밖의 궁금한 점")
                            .pretendard(.bold, 16)
                            .foregroundStyle(.accent)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 12) {
                                Label {
                                    Text("스크린 타임은 어떤 권한인가요?".byCharWrapping)
                                } icon: {
                                    Text("1.")
                                }
                                .pretendard(.semibold, 16)
                                
                                Label {
                                    Text("스크린 타임 접근을 허용하면, 후라이가 사용자의 앱 사용시간을 파악하고, 앱 사용을 제한할 수 있어요. 보안 정책상 후라이는 사용자의 앱 사용 시간에 이외에 다른 것들은 알 수 없어요.".byCharWrapping)
                                } icon: {
                                    Text("•")
                                }
                                .pretendard(.medium, 14)
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Label {
                                    Text("잠깐 쉴래요는 어떤 기능인가요?".byCharWrapping)
                                } icon: {
                                    Text("2.")
                                }
                                .pretendard(.semibold, 16)
                                
                                Label {
                                    Text("다이어트 기간 중 치팅 데이처럼, 가끔은 밤 늦게까지 놀고 싶은 때가 있을 수 있잖아요. 그래서, 잠깐 쉬는 동안은 사용시간 상관없이 자유롭게 핸드폰을 사용할 수 있어요.".byCharWrapping)
                                } icon: {
                                    Text("•")
                                }
                                .pretendard(.medium, 14)
                                
                                Label {
                                    Text("잊지 않고 후라이를 다시 사용하도록 알림을 보내드려요. 그때 잠깐 쉴래요 기능을 꺼주세요.".byCharWrapping)
                                } icon: {
                                    Text("•")
                                }
                                .pretendard(.medium, 14)
                            }
                        }
                    }
                    .padding(20)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.white.opacity(0.1))
                    }
                }
                .padding(20)
                .labelStyle(HuraiGuideLabelStyle())
                .kerning(-0.4)
            }
        }
        .background(.huraiBackground)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    GuideView()
}

extension String {
    var byCharWrapping: Self {
        map(String.init).joined(separator: "\u{200B}")
    }
}

struct HuraiGuideLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .top, spacing: 0) {
            configuration.icon
                .frame(width: 22)
            configuration.title
        }
    }
}
