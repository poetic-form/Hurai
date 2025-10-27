//
//  InfoEditView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/18/25.
//

import SwiftUI
import ManagedSettings

struct InfoEditView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button {
                        viewModel.fetchAllInfos()
                        viewModel.showEditSheet = false
                    } label: {
                        Text("취소")
                            .pretendard(.regular, 16)
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.updateAllInfos()
                        viewModel.startMonitoring()
                        viewModel.showEditSheet = false
                    } label: {
                        Text("확인")
                            .pretendard(.regular, 16)
                            .foregroundStyle(.accent)
                    }
                }
                .padding([.horizontal, .top], 20)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 30) {
                        Label {
                            Text("설정을 바꾸면 총 사용시간 측정이 다시 시작됩니다.")
                                .pretendard(.medium, 14)
                        } icon: {
                            Image(systemName: "exclamationmark.circle")
                        }
                        .foregroundStyle(.huraiLightGray)
                        
                        NavigationLink {
                            HomeAppSelectionView()
                        } label: {
                            HStack(spacing: 0) {
                                Text("앱 설정")
                                    .pretendard(.semibold, 16)
                                    .foregroundStyle(.white)
                                    .padding(.leading, 20)
                                    .padding(.vertical, 14)
                                
                                Spacer()
                                
                                HStack(spacing: 0) {
                                    ForEach(viewModel.returnApplicationTokens(), id: \.self) { token in
                                        Label(token)
                                            .labelStyle(.iconOnly)
                                    }
                                    
                                    ForEach(viewModel.returnWebDomainTokens(), id: \.self) { token in
                                        Label(token)
                                            .labelStyle(.iconOnly)
                                    }
                                }
                                
                                Image(systemName: "chevron.forward")
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 20)
                                    .padding(.leading, 15)
                                    .foregroundStyle(.white)
                            }
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.white.opacity(0.1))
                            }
                        }
                        .padding(.bottom, 20)
                        
                        VStack {
                            VStack(spacing: 37) {
                                HStack {
                                    Text("수면 시간")
                                        .pretendard(.bold, 20)
                                        .foregroundStyle(.white)
                                    
                                    Spacer()
                                }
                                
                                HuraiTimeSlider(startInterval: $viewModel.startInterval, endInterval: $viewModel.endInterval)
                            }
                            
                            Divider()
                                .frame(height: 1)
                                .background(.white.opacity(0.1))
                                .padding(.vertical, 20)
                            
                            VStack(spacing: 20) {
                                HStack {
                                    Text("오늘의 목표 시간")
                                        .pretendard(.bold, 20)
                                        .foregroundStyle(.white)
                                    
                                    Spacer()
                                }
                                
                                HuraiThresholdPickerView(threshold: $viewModel.threshold)
                            }
                            
                            Spacer()
                        }
                    }
                }
                .padding(20)
            }
            .scrollContentBackground(.hidden)
            .background(.huraiBackground)
        }
    }
}

#Preview {
    InfoEditView()
        .environmentObject(HomeViewModel())
}
