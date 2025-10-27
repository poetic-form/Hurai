//
//  HomeView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/6/25.
//

import SwiftUI
import FamilyControls
import ManagedSettings

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    
    @AppStorage("registeredAt", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var registeredAt: Date = .now
    
    @AppStorage("missionState", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var missionState: Int = 0
    
    private var ampmtimeFormatter: DateFormatter {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US")
        f.dateFormat = "a"
        return f
    }
    
    private var timeFormatter: DateFormatter {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US")
        f.dateFormat = "hh:mm"
        return f
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Hurai")
                        .uhbee(24)
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                .padding(.bottom, 30)
                
                HStack {
                    if missionState == 0 {
                        Text("오늘도\n병아리를 지켜주세요!")
                            .pretendard(.bold, 26)
                            .foregroundStyle(.white)
                            .lineSpacing(8)
                    } else if missionState == 1 {
                        Text("병아리가\n후라이가 되었어요!")
                            .pretendard(.bold, 26)
                            .foregroundStyle(.white)
                            .lineSpacing(8)
                    } else if missionState == 2 {
                        Text("어제는\n병아리를 지켜냈어요!")
                            .pretendard(.bold, 26)
                            .foregroundStyle(.white)
                            .lineSpacing(8)
                    }
                    
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    
                    if missionState == 0 {
                        Image(.huraiEgg)
                            .resizable()
                            .frame(width: 217, height: 153)
                            .offset(x: 20)
                    } else if missionState == 1 {
                        Image(.huraiCooked)
                            .resizable()
                            .frame(width: 226, height: 153)
                            .offset(x: 10)
                    } else if missionState == 2 {
                        Image(.huraiHatch)
                            .resizable()
                            .frame(width: 222, height: 153)
                            .offset(x: 15)
                    }
                }
            }
            .padding([.horizontal, .bottom], 20)
            .background {
                let cornerRadii: RectangleCornerRadii = .init(bottomLeading: 50, bottomTrailing: 50)
                UnevenRoundedRectangle(cornerRadii: cornerRadii)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.huraiSecondary, .accent]), startPoint: .top, endPoint: .bottom))
                    .ignoresSafeArea(edges: .top)
            }
            
            Button {
                viewModel.showEditSheet = true
            } label: {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(.huraiDarkGray)
                    .overlay {
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading, spacing: 22) {
                                    Label {
                                        Text("오늘의 목표 시간")
                                            .pretendard(.semibold, 15)
                                            .foregroundStyle(.white)
                                    } icon: {
                                        Image(systemName: "flame")
                                            .foregroundStyle(.accent)
                                    }
                                    
                                    Text("\(viewModel.threshold)분")
                                        .foregroundStyle(.white)
                                        .pretendard(.semibold, 36)
                                        .padding(.leading, 8)
                                    
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .layoutPriority(1)
                                
                                VStack(alignment: .leading, spacing: 22) {
                                    Text("수면 시간")
                                        .pretendard(.semibold, 15)
                                        .foregroundStyle(.white)
                                    
                                    HStack(spacing: 14) {
                                        Divider()
                                            .frame(width: 1)
                                            .background(.accent)
                                        
                                        VStack(alignment: .leading) {
                                            Label {
                                                HStack(alignment: .bottom, spacing: 6) {
                                                    Text("\(ampmtimeFormatter.string(from: viewModel.startInterval))")
                                                        .pretendard(.medium, 14)
                                                        .foregroundStyle(.white.opacity(0.3))
                                                    Text("\(timeFormatter.string(from: viewModel.startInterval))")
                                                        .pretendard(.semibold, 22)
                                                        .foregroundStyle(.white)
                                                }
                                                .monospacedDigit()
                                            } icon: {
                                                Image(systemName: "moon.zzz.fill")
                                            }
                                            .labelStyle(HuraiHomeViewLabelStyle())
                                            
                                            Spacer()
                                            
                                            Label {
                                                HStack(alignment: .bottom, spacing: 6) {
                                                    Text("\(ampmtimeFormatter.string(from: viewModel.endInterval))")
                                                        .pretendard(.medium, 14)
                                                        .foregroundStyle(.white.opacity(0.3))
                                                    Text("\(timeFormatter.string(from: viewModel.endInterval))")
                                                        .pretendard(.semibold, 22)
                                                        .foregroundStyle(.white)
                                                }
                                                .monospacedDigit()
                                            } icon: {
                                                Image(systemName: "sun.max.fill")
                                            }
                                            .labelStyle(HuraiHomeViewLabelStyle())
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .layoutPriority(1)
                            }
                            .padding(.top, 30)
                            .padding(.horizontal, 16)
                            
                            VStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.huraiGray)
                                    .frame(height: 82)
                                    .padding(16)
                                    .overlay {
                                        HStack {
                                            ForEach(viewModel.returnApplicationTokens(), id: \.self) { token in
                                                ZStack {
                                                    Image(.huraiSilhouette)
                                                        .renderingMode(.template)
                                                        .resizable()
                                                        .frame(width: 43, height: 49)
                                                        .foregroundStyle(.huraiDarkGray)
                                                    
                                                    Label(token)
                                                        .labelStyle(.iconOnly)
                                                        .offset(y: 2)
                                                }
                                                .frame(maxWidth: .infinity)
                                                .layoutPriority(1)
                                            }
                                            
                                            ForEach(viewModel.returnWebDomainTokens(), id: \.self) { token in
                                                ZStack {
                                                    Image(.huraiSilhouette)
                                                        .renderingMode(.template)
                                                        .resizable()
                                                        .frame(width: 43, height: 49)
                                                        .foregroundStyle(.huraiDarkGray)
                                                    
                                                    Label(token)
                                                        .labelStyle(.iconOnly)
                                                        .offset(y: 2)
                                                }
                                                .frame(maxWidth: .infinity)
                                                .layoutPriority(1)
                                            }
                                            
                                            let count =  5 - (viewModel.returnApplicationTokens().count + viewModel.returnWebDomainTokens().count)

                                            ForEach(0..<max(count, 0), id: \.self) { _ in
                                                Image(.huraiSilhouette)
                                                    .renderingMode(.template)
                                                    .resizable()
                                                    .frame(width: 43, height: 49)
                                                    .foregroundStyle(.huraiDarkGray)
                                                    .frame(maxWidth: .infinity)
                                                    .layoutPriority(1)
                                            }
                                        }
                                        .padding(30)
                                    }
                            }
                        }
                    }
                    .frame(maxHeight: 370)
            }
            .padding(16)
            
            Spacer()
        }
        .background(.huraiBackground)
        .onAppear {
            viewModel.fetchAllInfos()
        }
        .sheet(isPresented: $viewModel.showEditSheet, onDismiss: { viewModel.fetchAllInfos() }) {
            InfoEditView()
                .dynamicTypeSize(.xSmall)
        }
    }
}

#Preview {
    RootView()
        .environmentObject(HomeViewModel())
        .environmentObject(SettingViewModel())
        .environmentObject(MissionViewModel())
}


struct HuraiHomeViewLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            configuration.icon
                .font(.system(size: 18))
                .foregroundStyle(.accent)
            
            configuration.title
                .tracking(-1)
        }
    }
}
