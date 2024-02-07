//
//  Theme.swift
// SetPoint
//
//  Created by Saad Ali on 7/27/20.
//  Copyright © 2020 Next Generation Innovation. All rights reserved.
//

import Foundation
import UIKit

// swiftlint:disable identifier_name
enum AppTheme {
    
    case syne_SemiBold_30_black
    case ovo_regular_30_black
    case syne_regular_16_black
    case syne_regular_12_black
    case syne_regular_12_lightGrey
    case syne_regular_12_white
    case syne_regular_16_grey
    case syne_regular_22_white
    case syne_regular_14_white
    case syne_regular_13_white
    case syne_regular_13_black
    case syne_regular_16_white
    case syne_regular_18_white
    case syne_regular_18_black
    case syne_regular_14_grey
    case syne_regular_14_grey_underline
    case syne_regular_12_grey
    case syne_regular_14_grey_centreAlign
    case syne_regular_10_black
    case syne_regular_10_white
    case syne_regular_10_clear
    case syne_regular_14_black
    case syne_regular_14_red
    case syne_regular_14_themeColor
    case syne_regular_14_themeColor_centerAlign
    case syne_regular_16_themeColor
    case syne_regular_12_themeColor
    case syne_regular_12_themeColor_underLine
    case syne_regular_12_liteThemeColor
    case syne_regular_14_themeColor_underLine
    case syne_regular_14_liteThemeColor_underLine_disabled
    case syne_regular_14_liteThemeColor
    case syne_regular_20_black
    case syne_regular_20_white
    case syne_regular_22_themeColor
    case syne_regular_12_orange
    case syne_regular_18_orange
    case syne_regular_14_disabled
    case syne_regular_13_disabled
    case syne_medium_14_white
    case syne_regular_24_white
    case syne_regular_10_disabled
    case syne_regular_16_disabled
    case syne_regular_16_orange
    case syne_regular_8_gray
    case syne_regular_10_gray
    case sye_regular_22_themeColor
    case sye_regular_16_themeColor
    case syne_regular_14_orange
    case syne_regular_12_gray
    case syne_regular_22_black
    case syne_regular_12_onhold
    case syne_regular_19_black
    
    
    private func getAttributes(font: AppFonts,
                               _ color: UIColor,
                               textAlignment: NSTextAlignment? = nil,
                               _ underline: Bool = false) -> [NSAttributedString.Key: Any] {
        
        let titleParagraphStyle = NSMutableParagraphStyle()
        
        let textAlignment: NSTextAlignment = textAlignment ?? NSTextAlignment.left
        
//        titleParagraphStyle.alignment = changeTextAlignmentIfNeeded(textAlignment)
        
        if underline {
            return [.font: font.getFont() as Any,
                    .foregroundColor: color,
                    .paragraphStyle: titleParagraphStyle,
                    .underlineColor: color,
                    .underlineStyle: 1]
        }
        return [.font: font.getFont() as Any,
                .foregroundColor: color,
                .paragraphStyle: titleParagraphStyle]
    }
    
//    private func changeTextAlignmentIfNeeded(_ alignment: NSTextAlignment) -> NSTextAlignment {
//
//        guard alignment == .right || alignment == .left else {
//            return alignment
//        }
//
//        return (currentLanguage() == .english ? (alignment) : (alignment == .right ? NSTextAlignment.left : NSTextAlignment.right))
//    }
}

extension AppTheme {
    
    var attributes: [NSAttributedString.Key: Any] {
        switch self {
        case .syne_SemiBold_30_black:
            return self.getAttributes(font: .syneSemiBold(engSize: 30.0), .blackText)
        case .ovo_regular_30_black:
            return self.getAttributes(font: .ovoRegular(engSize: 30.0), .blackText)
        case .syne_regular_16_black:
            return self.getAttributes(font: .syneRegular(engSize: 16.0), .blackText)
        case .syne_regular_16_grey:
            return self.getAttributes(font: .syneRegular(engSize: 16.0), .lightGreyText)
        case .syne_regular_22_white:
            return self.getAttributes(font: .syneRegular(engSize: 22.0), .white)
        case .syne_regular_14_white:
            return self.getAttributes(font: .syneRegular(engSize: 14.0), .white)
        case .syne_regular_16_white:
            return self.getAttributes(font: .syneRegular(engSize: 16.0), .white)
        case .syne_regular_18_white:
            return self.getAttributes(font: .syneRegular(engSize: 18.0), .white)
        case .syne_regular_18_black:
            return self.getAttributes(font: .syneRegular(engSize: 18.0), .blackText)
        case .syne_regular_14_grey:
            return self.getAttributes(font: .syneRegular(engSize: 14.0), .lightGreyText)
        case .syne_regular_14_grey_underline:
            return self.getAttributes(font: .syneRegular(engSize: 14.0), .lightGreyText, true)
        case .syne_regular_14_grey_centreAlign:
            return self.getAttributes(font: .syneRegular(engSize: 14.0), .lightGreyText,textAlignment: .center)
        case .syne_regular_14_themeColor:
            return self.getAttributes(font: .syneRegular(engSize: 14.0), UIColor.themeColor)
        case .syne_regular_14_themeColor_centerAlign:
            return self.getAttributes(font: .syneRegular(engSize: 14.0), UIColor.themeColor,textAlignment: .center)
        case .syne_regular_12_themeColor_underLine:
            return self.getAttributes(font: .syneRegular(engSize: 12.0), UIColor.themeColor, true)
        case .syne_regular_12_black:
            return self.getAttributes(font: .syneRegular(engSize: 12.0), .blackText)
        case .syne_regular_12_liteThemeColor:
            return self.getAttributes(font: .syneRegular(engSize: 12.0), .liteThemeColor)
        case .syne_regular_12_white:
            return self.getAttributes(font: .syneRegular(engSize: 12.0), .white)
        case .syne_regular_10_black:
            return self.getAttributes(font: .syneRegular(engSize: 10.0), .blackText)
        case .syne_regular_14_themeColor_underLine:
            return self.getAttributes(font: .syneRegular(engSize: 14.0), UIColor.themeColor, true)
        case .syne_regular_14_black:
            return self.getAttributes(font: .syneRegular(engSize: 14.0), .blackText)
        case .syne_regular_14_red:
            return self.getAttributes(font: .syneRegular(engSize: 14.0), .red)
        case .syne_regular_16_themeColor:
            return self.getAttributes(font: .syneRegular(engSize: 16.0), UIColor.themeColor)
        case .syne_regular_12_themeColor:
            return self.getAttributes(font: .syneRegular(engSize: 12.0), UIColor.themeColor)
        case .syne_regular_12_lightGrey:
            return self.getAttributes(font: .syneRegular(engSize: 12.0), .lightGreyText)
        case .syne_regular_14_liteThemeColor:
            return self.getAttributes(font: .syneRegular(engSize: 14.0), .liteThemeColor)
        case .syne_regular_20_black:
            return self.getAttributes(font: .syneRegular(engSize: 20.0), .blackText)
        case .syne_regular_20_white:
            return self.getAttributes(font: .syneRegular(engSize: 20.0), .white)
        case .syne_regular_22_themeColor:
            return self.getAttributes(font: .syneRegular(engSize: 22.0), .themeColor)
        case .syne_regular_12_orange:
            return self.getAttributes(font: .syneRegular(engSize: 12.0), .orange)
        case .syne_regular_14_disabled:
            return self.getAttributes(font: .syneRegular(engSize: 14.0), .disabledGrey)
        case .syne_regular_13_white:
            return self.getAttributes(font: .syneRegular(engSize: 13.0), .white)
        case .syne_regular_13_black:
            return self.getAttributes(font: .syneRegular(engSize: 13.0), .blackText)
        case .syne_regular_13_disabled:
            return self.getAttributes(font: .syneRegular(engSize: 13.0), .disabledGrey)
        case .syne_medium_14_white:
            return self.getAttributes(font: .syneMedium(engSize: 14.0), .white)
        case .syne_regular_10_disabled:
            return self.getAttributes(font: .syneRegular(engSize: 10.0), .disabledGrey)
        case .syne_regular_16_disabled:
            return self.getAttributes(font: .syneRegular(engSize: 16.0), .disabledGrey)
        case .syne_regular_14_liteThemeColor_underLine_disabled:
            return self.getAttributes(font: .syneRegular(engSize: 14.0), .liteThemeColor)
        case .syne_regular_10_white:
            return self.getAttributes(font: .syneRegular(engSize: 10.0), .white)
        case .syne_regular_10_clear:
            return self.getAttributes(font: .syneRegular(engSize: 10.0), .clearColor)
        case .syne_regular_24_white:
            return self.getAttributes(font: .syneRegular(engSize: 24.0), .white)
        case .syne_regular_16_orange:
            return self.getAttributes(font: .syneRegular(engSize: 16.0), .orange)
        case .syne_regular_8_gray:
            return self.getAttributes(font: .syneRegular(engSize: 8.0), .lightGreyText)
        case .syne_regular_10_gray:
            return self.getAttributes(font: .syneRegular(engSize: 10.0), .lightGreyText)
        case .sye_regular_22_themeColor:
            return self.getAttributes(font: .syneRegular(engSize: 22.0), .themeColor)
        case .sye_regular_16_themeColor:
            return self.getAttributes(font: .syneRegular(engSize: 16.0), .themeColor)
        case .syne_regular_14_orange:
            return self.getAttributes(font: .syneRegular(engSize: 14.0), .orange)
        case .syne_regular_12_gray:
            return self.getAttributes(font: .syneRegular(engSize: 12.0), .lightGreyText)
        case .syne_regular_22_black:
            return self.getAttributes(font: .syneRegular(engSize: 22.0), .blackText)
        case .syne_regular_12_grey:
            return self.getAttributes(font: .syneRegular(engSize: 12.0), .lightGreyText)
        case .syne_regular_12_onhold:
            return self.getAttributes(font: .syneRegular(engSize: 12.0), .lightGray)
        case .syne_regular_19_black:
            return self.getAttributes(font: .syneRegular(engSize: 19.0), .blackText)
        case .syne_regular_18_orange:
            return self.getAttributes(font: .syneSemiBold(engSize: 18.0), .orange)
        }
    }
}
