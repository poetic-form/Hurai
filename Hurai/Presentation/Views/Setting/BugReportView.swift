//
//  BugReportView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/29/25.
//

import SwiftUI

struct BugReportView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: SettingViewModel
    @FocusState private var focusedField: Bool
    
    var body: some View {
        VStack {
            HuraiNavigationBar(title: "오류 신고")
            
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    Text("사용하면서 불편했던 점이나\n오류에 대해 알려주세요")
                        .pretendard(.bold, 26)
                        .foregroundStyle(.white)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("제목")
                                .pretendard(.semibold, 16)
                                .foregroundStyle(.white)
                                .padding(.leading, 10)
                            TextField("", text: $viewModel.reportTitle)
                                .overlay(alignment:.leading) {
                                    if viewModel.reportTitle.isEmpty {
                                        Text("제목을 입력해주세요.")
                                            .pretendard(.medium, 16)
                                            .foregroundStyle(.white.opacity(0.5))
                                            .allowsHitTesting(false)
                                    }
                                }
                                .pretendard(.medium, 16)
                                .lineSpacing(0)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 14)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(.white.opacity(0.1))
                                }
                                .focused($focusedField)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("이메일")
                                .pretendard(.semibold, 16)
                                .foregroundStyle(.white)
                                .padding(.leading, 10)
                            TextField("", text: $viewModel.reportEmail)
                                .overlay(alignment:.leading) {
                                    if viewModel.reportEmail.isEmpty {
                                        Text("답변 받을 이메일을 입력해주세요.")
                                            .pretendard(.medium, 16)
                                            .foregroundStyle(.white.opacity(0.5))
                                            .allowsHitTesting(false)
                                    }
                                }
                                .pretendard(.medium, 16)
                                .lineSpacing(0)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 14)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(.white.opacity(0.1))
                                }
                                .focused($focusedField)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("내용")
                                    .pretendard(.semibold, 16)
                                    .foregroundStyle(.white)
                                    .padding(.leading, 10)
                                
                                Spacer()
                                
                                Text("\(viewModel.reportMessage.count)/300")
                                    .pretendard(.regular, 16)
                                    .foregroundStyle(.huraiLightGray.opacity(0.8))
                                    .padding(.trailing, 10)
                            }
                            
                            VStack {
                                TextEditor(text: $viewModel.reportMessage)
                                    .overlay(alignment:.topLeading) {
                                        if viewModel.reportMessage.isEmpty {
                                            Text("오류 내용을 입력해주세요.\n(ex. 앱이 하나만 선택돼요. 목표시간 측정이 안되는 것 같아요.)")
                                                .padding(8)
                                                .pretendard(.medium, 16)
                                                .foregroundStyle(.white.opacity(0.5))
                                                .allowsHitTesting(false)
                                        }
                                    }
                                    .pretendard(.medium, 16)
                                    .lineSpacing(4)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 14)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundStyle(.white.opacity(0.1))
                                    }
                                    .scrollContentBackground(.hidden)
                                    .scrollDisabled(true)
                                    .focused($focusedField)
                                    .onChange(of: viewModel.reportMessage) { newValue in
                                        if newValue.count > 300 {
                                            viewModel.reportMessage = String(newValue.prefix(300))
                                        }
                                    }
                                Spacer()
                            }
                            .frame(height: 380)
                        }
                    }
                }
                .padding(20)
                
                HuraiButton(title: "오류 신고하기") {
                    focusedField = false
                    viewModel.checkNetworkStatus()
                    viewModel.showLoading = true
                }
                .disabled(viewModel.reportMessage.isEmpty)
            }
        }
        .foregroundStyle(.white)
        .labelStyle(HuraiGuideLabelStyle())
        .kerning(-0.4)
        .lineSpacing(6)
        .navigationBarBackButtonHidden()
        .background(.huraiBackground)
        .overlay {
            if viewModel.showLoading {
                if viewModel.networkStatus == .satisfied {
                    ZStack {
                        Rectangle()
                            .ignoresSafeArea()
                            .foregroundStyle(.huraiBackground)
                            .overlay(alignment: .bottom) {
                                HuraiButton(title: "확인") {
                                    viewModel.resetSetting()
                                    dismiss()
                                }
                            }
                        
                        VStack(spacing: 36) {
                            Image(.huraiReport)
                                .resizable()
                                .frame(width: 214, height: 171)
                            
                            Text("오류 신고가 완료되었어요")
                                .pretendard(.bold, 24)
                                .foregroundStyle(.white)
                            
                            Text("신고 내용을 확인한 후\n입력하신 이메일로 답변드릴게요")
                                .pretendard(.regular, 16)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }
                    .onAppear {
                        viewModel.sendDiscordWebhook()
                    }
                } else if viewModel.networkStatus == .unsatisfied {
                    ZStack {
                        Rectangle()
                            .ignoresSafeArea()
                            .foregroundStyle(.huraiBlack.opacity(0.9))
                            .overlay(alignment: .topTrailing) {
                                Button {
                                    viewModel.showLoading = false
                                    viewModel.networkStatus = nil
                                } label: {
                                    Image(systemName: "xmark")
                                        .font(.system(size: 24))
                                        .foregroundStyle(.white)
                                        .padding(30)
                                }
                            }
                        
                        VStack(spacing: 36) {
                            Image(.huraiFail)
                                .resizable()
                                .frame(width: 172, height: 190)
                            
                            Text("오류 신고에 실패했어요")
                                .pretendard(.bold, 24)
                                .foregroundStyle(.white)
                            
                            Text("인터넷 연결을 확인하고\n다시 한 번 오류를 신고해주세요")
                                .pretendard(.regular, 16)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BugReportView()
        .environmentObject(SettingViewModel())
}
