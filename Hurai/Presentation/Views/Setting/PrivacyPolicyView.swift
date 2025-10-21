//
//  PrivacyPolicyView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/29/25.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        VStack {
            HuraiNavigationBar(title: "개인정보 처리방침")
            
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 22) {
                            Text("🔒 “후라이”는 디지털 디톡스 앱 “후라이”(이하 ‘본 앱’)를 운영합니다.".byCharWrapping)
                                .pretendard(.bold, 16)
                                .foregroundStyle(.white)
                            
                            Text("본 앱은 사용자에게 알림 권한 및 스크린타임 연동 권한을 요청하며, 일부 비식별 정보(usage 및 진단 데이터)를 수집합니다. 그러나 모든 데이터는 사용자의 기기 내에 로컬로 저장되며, 서버로 전송되거나 외부에 공유되지 않습니다.\n\n본 앱을 사용하는 경우, 아래의 개인정보 처리방침에 동의하는 것으로 간주합니다.".byCharWrapping)
                                .pretendard(.medium, 16)
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(20)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.white.opacity(0.1))
                    }
                    
                    VStack(alignment: .leading, spacing: 22) {
                        Text("수집 및 이용되는 데이터")
                            .pretendard(.bold, 16)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("✅ 사용 데이터")
                                .pretendard(.semibold, 16)
                            Text("후라이는 사용자의 식별이 불가능한 비식별 사용 데이터를 수집할 수 있습니다. 이 데이터는 어떤 기능이 얼마나 사용되는지 등을 파악해 앱의 성능을 개선하고 사용자 경험을 향상시키기 위한 용도로만 사용됩니다.".byCharWrapping)
                                .pretendard(.medium, 16)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("✅ 진단 정보")
                                .pretendard(.semibold, 16)
                            Text("앱의 안정성과 오류 수정을 위해 비식별 형태의 진단 데이터를 수집할 수 있습니다. 이 데이터는 오직 버그 수정 및 서비스 개선에만 사용되며, 외부 공유나 상업적 활용은 하지 않습니다.".byCharWrapping)
                                .pretendard(.medium, 16)
                        }
                    }
                    
                    Divider()
                        .background(.white.opacity(0.2))
                    
                    VStack(alignment: .leading, spacing: 22) {
                        Text("2. 데이터 저장 방식")
                            .pretendard(.bold, 16)
                        
                        Text("모든 데이터는 사용자의 기기 내에 로컬로 저장되며, 개발자 서버 등 외부 저장소에 전송되지 않습니다. 앱 삭제 시 모든 데이터는 자동으로 삭제됩니다.".byCharWrapping)
                            .pretendard(.medium, 16)
                    }
                    
                    Divider()
                        .background(.white.opacity(0.2))
                    
                    VStack(alignment: .leading, spacing: 22) {
                        Text("3. 접근 권한 안내")
                            .pretendard(.bold, 16)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("본 앱은 아래의 접근 권한을 요청합니다:")
                            
                            Label {
                                Text("알림 권한: 설정한 디지털 디톡스 시간 도달 여부를 알리기 위해 사용됩니다.".byCharWrapping)
                            } icon: {
                                Text("•")
                            }
                            
                            Label {
                                Text("스크린타임 연동 권한 (iOS API): 사용자의 기기 사용 시간을 확인하여 목표 달성 여부를 판단하기 위해 사용됩니다.".byCharWrapping)
                            } icon: {
                                Text("•")
                            }
                        }
                        .pretendard(.medium, 16)
                        
                        Text("이 외의 어떠한 권한도 요청하지 않으며, 권한 허용은 사용자가 직접 설정할 수 있습니다.".byCharWrapping)
                            .pretendard(.medium, 16)
                    }
                    
                    Divider()
                        .background(.white.opacity(0.2))
                    
                    VStack(alignment: .leading, spacing: 22) {
                        Text("4. 개인정보 보유 및 파기")
                            .pretendard(.bold, 16)
                        
                        Text("후라이는 서버에 개인정보를 저장하지 않기 때문에, 별도의 장기 보관 기간이 적용되지 않습니다.\n모든 데이터는 사용자의 기기에만 존재하며, 앱 삭제 시 자동으로 파기됩니다.".byCharWrapping)
                            .pretendard(.medium, 16)
                    }
                    
                    Divider()
                        .background(.white.opacity(0.2))
                    
                    VStack(alignment: .leading, spacing: 22) {
                        Text("5. 개인정보처리방침의 변경")
                            .pretendard(.bold, 16)
                        
                        Text("후라이는 본 개인정보처리방침을 수시로 변경할 수 있습니다. 변경 시 본 페이지 및 앱스토어 상세정보를 통해 고지됩니다.\n이용자는 정기적으로 본 방침을 검토하시기 바랍니다.".byCharWrapping)
                            .pretendard(.medium, 16)
                    }
                    
                    Divider()
                        .background(.white.opacity(0.2))
                    
                    VStack(alignment: .leading, spacing: 22) {
                        Text("5. 개인정보처리방침의 변경")
                            .pretendard(.bold, 16)
                        
                        Text("후라이는 본 개인정보처리방침을 수시로 변경할 수 있습니다. 변경 시 본 페이지 및 앱스토어 상세정보를 통해 고지됩니다.\n이용자는 정기적으로 본 방침을 검토하시기 바랍니다.".byCharWrapping)
                            .pretendard(.medium, 16)
                        
                        Label {
                            Text("최종 업데이트: 2025년 8월 2일")
                        } icon: {
                            Text("•")
                        }
                        .pretendard(.medium, 16)
                    }
                    
                    Divider()
                        .background(.white.opacity(0.2))
                    
                    VStack(alignment: .leading, spacing: 22) {
                        Text("6. 문의처")
                            .pretendard(.bold, 16)
                        
                        Text("개인정보 처리 관련 문의는 아래 연락처를 통해 가능하며, 최대한 신속히 응답드리겠습니다.".byCharWrapping)
                            .pretendard(.medium, 16)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Label {
                                Text("문의 이메일")
                            } icon: {
                                Text("•")
                            }
                            .pretendard(.medium, 16)
                            
                            Label {
                                Text("poeticformlee@gmail.com")
                                    .underline()
                            } icon: {
                                Text("•")
                            }
                            .pretendard(.medium, 16)
                            .padding(.leading, 22)
                        }
                    }
                }
                .padding(20)
            }
            .foregroundStyle(.white)
            .labelStyle(HuraiGuideLabelStyle())
            .kerning(-0.4)
            .lineSpacing(6)
        }
        .navigationBarBackButtonHidden()
        .background(.huraiBackground)
    }
}

#Preview {
    PrivacyPolicyView()
}
