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
    
    private var timeFormatter: DateFormatter {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "a hh : mm"
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
            
            RoundedRectangle(cornerRadius: 30)
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
                .pretendard(.semibold, 22)
                .foregroundStyle(.white)
                .tracking(-1)
        }
    }
}
