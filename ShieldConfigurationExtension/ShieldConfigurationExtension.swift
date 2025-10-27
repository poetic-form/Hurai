//
//  ShieldConfigurationExtension.swift
//  ShieldConfigurationExtension
//
//  Created by Sihyeong Lee on 8/2/25.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit
import SwiftUI

// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    @AppStorage("isDefered", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var isDefered: Bool = false
    
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        // Customize the shield as needed for applications.
        makeConfiguration()
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for applications shielded because of their category.
        makeConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        makeConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for web domains shielded because of their category.
        makeConfiguration()
    }
    
    func makeConfiguration() -> ShieldConfiguration {
        let icon: UIImage = isDefered ? .huraiPeeking : .huraiUpside
        let title = ShieldConfiguration.Label(text: isDefered ? "목표한 시간만큼 사용했어요\n이제 자러 갈 시간!" : "조금 더 사용하려면\n위의 알림을 눌러주세요", color: .white)
        let subtitle = ShieldConfiguration.Label(text: isDefered ? "" : "알림이 오지 않는다면\n알림을 허용하거나 방해금지 모드를 확인해주세요", color: .huraiGray)
        let primaryButton = ShieldConfiguration.Label(text: "자러 가기", color: .huraiBlack)
        let secondaryButton = ShieldConfiguration.Label(text: isDefered ? "조금 더 사용하기" : "알림 다시 받기", color: .white)
        
        return ShieldConfiguration(
            backgroundColor: .huraiBackground,
            icon: icon,
            title: title,
            subtitle: subtitle,
            primaryButtonLabel: isDefered ? primaryButton : nil,
            primaryButtonBackgroundColor: .accent,
            secondaryButtonLabel: secondaryButton
        )
    }
}
