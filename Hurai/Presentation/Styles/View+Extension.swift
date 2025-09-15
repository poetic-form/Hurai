//
//  Font+Extension.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/5/25.
//

import SwiftUI

extension View {
    func pretendard(
        _ weight: Font.Weight,
        _ size: CGFloat,
        relativeTo textStyle: Font.TextStyle? = nil
    ) -> some View {
        let fontName: String
        switch weight {
        case .black:      fontName = "Pretendard-Black"
        case .bold:       fontName = "Pretendard-Bold"
        case .heavy:      fontName = "Pretendard-ExtraBold"
        case .semibold:   fontName = "Pretendard-SemiBold"
        case .medium:     fontName = "Pretendard-Medium"
        case .regular:    fontName = "Pretendard-Regular"
        case .light:      fontName = "Pretendard-Light"
        case .thin:       fontName = "Pretendard-Thin"
        case .ultraLight: fontName = "Pretendard-ExtraLight"
        default:          fontName = "Pretendard-Regular"
        }
        
        if let textStyle = textStyle {
            return self.font(.custom(fontName, size: size, relativeTo: textStyle))
        } else {
            return self.font(.custom(fontName, size: size))
        }
    }
}

extension View {
    func uhbee(
        _ size: CGFloat,
        relativeTo textStyle: Font.TextStyle? = nil
    ) -> some View {
        let fontName: String = "UhBeeGmin2Bold"
        
        if let textStyle = textStyle {
            return self.font(.custom(fontName, size: size, relativeTo: textStyle))
        } else {
            return self.font(.custom(fontName, size: size))
        }
    }
}

