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
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "gear")
                            .font(.system(size: 26))
                            .foregroundStyle(.white)
                    }
                }
                .padding(.vertical, 30)
                
                HStack {
                    Text("오늘도\n병아리를 지켜주세요!")
                        .pretendard(.bold, 26)
                        .foregroundStyle(.white)
                        .lineSpacing(8)
                    
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    
                    Image(.huraiChiken)
                        .resizable()
                        .frame(width: 100, height: 110)
                }
            }
            .padding([.horizontal, .bottom], 20)
            .background {
                let cornerRadii: RectangleCornerRadii = .init(bottomLeading: 50, bottomTrailing: 50)
                UnevenRoundedRectangle(cornerRadii: cornerRadii)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.huraiSecondary, .accent]), startPoint: .top, endPoint: .bottom))
                    .ignoresSafeArea(edges: .top)
            }
            
            VStack(spacing: 26) {
                HStack(spacing: 14) {
                    RoundedRectangle(cornerRadius: 30)
                        .overlay {
                            VStack {
                                HStack {
                                    VStack(alignment: .leading, spacing: 17) {
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
                                            .pretendard(.bold, 36)
                                    }
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    
                                    Image(.huraiWatch)
                                        .resizable()
                                        .frame(width: 63, height: 63)
                                }
                            }
                            .padding(20)
                        }
                    
                    RoundedRectangle(cornerRadius: 30)
                        .overlay {
                            HStack {
                                VStack(alignment: .leading, spacing: 20) {
                                    Text("수면 시간")
                                        .pretendard(.semibold, 15)
                                        .foregroundStyle(.white)
                                    
                                    HStack(spacing: 14) {
                                        Divider()
                                            .frame(width: 2)
                                            .background(.accent)
                                        
                                        VStack(alignment: .leading) {
                                            Label("\(timeFormatter.string(from: viewModel.startInterval))", systemImage: "moon.zzz.fill")
                                                .labelStyle(HuraiHomeViewLabelStyle())
                                                .monospacedDigit()
                                            
                                            Spacer()
                                            
                                            Label("\(timeFormatter.string(from: viewModel.endInterval))", systemImage: "sun.max.fill")
                                                .labelStyle(HuraiHomeViewLabelStyle())
                                                .monospacedDigit()
                                        }
                                    }
                                }
                                
                                Spacer()
                            }
                            .padding(20)
                        }
                }
                
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: 92)
                    .overlay {
                        HStack(spacing: 30) {
                            ForEach(Array(viewModel.storage.selections.applicationTokens).sorted(by: { $0.rawValue < $1.rawValue} ), id: \.self) { token in
                                Label(token)
                                    .labelStyle(.iconOnly)
                                    .background {
                                    GeometryReader { proxy in
                                       Rectangle()
                                            .onAppear {
                                                print("width:", proxy.size.width,
                                                      "height:", proxy.size.height)
                                            }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
            }
            .foregroundStyle(.white.opacity(0.06))
            .padding(20)
            
            Spacer()
        }
        .background(.huraiBackground)
        .onAppear {
            viewModel.fetchInterval()
            viewModel.fetchThreshold()
            viewModel.fetchSelections()
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
