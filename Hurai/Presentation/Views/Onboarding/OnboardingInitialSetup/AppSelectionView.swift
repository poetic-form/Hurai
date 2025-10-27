//
//  AppSelectionView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/10/25.
//

import SwiftUI
import ManagedSettings

struct AppSelectionView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("나의 수면시간을 방해하는 \n앱을 선택해주세요")
                    .pretendard(.bold, 24)
                    .foregroundStyle(.white)
                    .lineSpacing(8)
                
                Text("최대 5개의 앱을 선택할 수 있어요.\n이후에도 선택한 앱을 삭제하거나 추가할 수 있어요.")
                    .pretendard(.regular, 16)
                    .foregroundStyle(.huraiLightGray)
                    .lineSpacing(4)
                    .padding(.bottom, 10)
                
                ForEach(Array(viewModel.storage.selections.applicationTokens).sorted(by: { $0.rawValue < $1.rawValue} ), id: \.self) { token in
                    selectionRowView(token: token)
                }
                
                ForEach(Array(viewModel.selections.webDomainTokens).sorted(by: { $0.rawValue < $1.rawValue} ), id: \.self) { token in
                    selectionRowView(token: token)
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
                                .foregroundStyle(.accent)
                        }
                }
            }
            .padding(20)
            
            Spacer()
            
            HuraiButton(title: "선택 완료") {
                viewModel.setupPage += 1
            }
            .disabled(viewModel.selections.applicationTokens.isEmpty &&
                      viewModel.selections.webDomainTokens.isEmpty)
        }
        .sheet(isPresented: $viewModel.showFamilyActivityPickerView, onDismiss: {
            viewModel.fetchSelections()
        }) {
            FamilyActivityPickerView()
        }
    }
    
    @ViewBuilder
    func selectionRowView<T>(token: Token<T>) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.white.opacity(0.04))
            .frame(height: 50)
            .overlay {
                HStack {
                    if let applicationToken = token as? ApplicationToken {
                        Label(applicationToken)
                            .labelStyle(HuraiTokenLabelStyle())
                        Spacer()
                        Button {
                            viewModel.selections.applicationTokens.remove(applicationToken)
                            viewModel.updateSelections()
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .padding(5)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    } else if let webDomainToken = token as? WebDomainToken {
                        Label(webDomainToken)
                            .labelStyle(HuraiTokenLabelStyle())
                        Spacer()
                        Button {
                            viewModel.selections.webDomainTokens.remove(webDomainToken)
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
                .padding()
            }
    }
}

#Preview {
    OnboardingInitialSetupView()
        .environmentObject(OnboardingViewModel())
}

struct HuraiTokenLabelStyle: LabelStyle {
    @Environment(\.colorScheme) private var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
            configuration.title.brightness(colorScheme == .dark ? 0 : 1) // title 색상
        }
    }
}
