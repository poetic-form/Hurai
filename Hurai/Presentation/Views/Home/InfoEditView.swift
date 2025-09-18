//
//  InfoEditView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/18/25.
//

import SwiftUI

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
                        viewModel.startMonitoring()
                        viewModel.showEditSheet = false
                    } label: {
                        Text("확인")
                            .pretendard(.regular, 16)
                            .foregroundStyle(.accent)
                    }
                }
                .padding([.horizontal, .top], 20)
                
                List {
                    Section(footer: Text("설정을 바꾸면 총 사용시간 측정이 다시 시작됩니다.").padding(.leading, -8).padding(.top, 15).pretendard(.medium, 14).foregroundStyle(.white)) {
                        NavigationLink {
                            HomeTimeSettingView()
                        } label: {
                            Text("시간 설정")
                                .pretendard(.semibold, 16)
                                .foregroundStyle(.white)
                                .padding(.vertical, 20)
                                .listRowBackground(Color.white.opacity(0.1))
                        }
                        
                        NavigationLink {
                            HomeAppSelectionView()
                        } label: {
                            Text("앱 설정")
                                .pretendard(.semibold, 16)
                                .foregroundStyle(.white)
                                .padding(.vertical, 20)
                                .listRowBackground(Color.white.opacity(0.1))
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                }
            }
        }
    }
}

#Preview {
    InfoEditView()
}
