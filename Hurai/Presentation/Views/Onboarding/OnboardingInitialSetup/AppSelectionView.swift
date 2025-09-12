//
//  AppSelectionView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/10/25.
//

import SwiftUI

struct AppSelectionView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("나의 수면시간을 방해하는 \n앱을 선택해주세요")
                    .pretendard(.bold, 24)
                    .foregroundStyle(.huraiWhite)
                
                Text("최대 5개의 앱을 선택할 수 있어요.\n이후에도 선택한 앱을 삭제하거나 추가할 수 있어요.")
                    .pretendard(.regular, 16)
                    .foregroundStyle(.huraiGray)
                
                ForEach(Array(viewModel.storage.selections.applicationTokens).sorted(by: { $0.rawValue < $1.rawValue} ), id: \.self) { token in
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white.opacity(0.04))
                        .frame(height: 50)
                        .overlay {
                            HStack {
                                Label(token)
                                Spacer()
                                Button {
                                    viewModel.selections.applicationTokens.remove(token)
                                    viewModel.updateSelections()
                                } label: {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                        .padding(5)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                            }
                            .padding()
                        }
                }
                
                ForEach(Array(viewModel.selections.webDomainTokens).sorted(by: { $0.rawValue < $1.rawValue} ), id: \.self) { token in
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white.opacity(0.04))
                        .frame(height: 50)
                        .overlay {
                            HStack {
                                Label(token)
                                    .padding()
                                Spacer()
                                Button {
                                    viewModel.selections.webDomainTokens.remove(token)
                                    viewModel.updateSelections()
                                } label: {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                        .padding(5)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                            }
                        }
                }
                
                Button {
                    viewModel.showFamilyActivityPickerView = true
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white.opacity(0.04))
                        .frame(height: 50)
                        .overlay {
                            Text("+ 앱 선택하기")
                                .pretendard(.semibold, 16)
                                .foregroundStyle(.huraiAccent)
                        }
                }
            }
            .padding(20)
            
            Spacer()
            
            HuraiButton(title: "선택 완료") {
                viewModel.setupPage += 1
            }
            .disabled(viewModel.selections.applicationTokens.isEmpty && viewModel.selections.webDomainTokens.isEmpty)
        }
        .sheet(isPresented: $viewModel.showFamilyActivityPickerView) {
            FamilyActivityPickerView()
        }
    }
}

#Preview {
    AppSelectionView()
        .environmentObject(OnboardingViewModel())
}

