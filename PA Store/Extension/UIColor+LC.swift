//
//  UIColor+LC.swift
//  HomeMedics
//
//  Created byDevBatch on 6/19/17.
//  Copyright © 2017DevBatch. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    class func CustomColorFromHexaWithAlpha (_ hex:String, alpha:CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in:(CharacterSet.whitespacesAndNewlines as CharacterSet) as CharacterSet).uppercased()

        if cString.hasPrefix("#") {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
        }

        if cString.count != 6 {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }

    func convertImage() -> UIImage {
        let rect : CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context : CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(self.cgColor)
        context.fill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return image
    }

    class func appThemeBlackColor(_ alpha: CGFloat = 1.0) -> UIColor {
        //let hex = "2d3939"
        return #colorLiteral(red: 0.8878073096, green: 0.1544833779, blue: 0.5785527825, alpha: 1)
    }

    class func createAccountButtonBackGroundColorWithAlpha(_ alpha: CGFloat) -> UIColor {
        let hex = "00A9BB"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: alpha)
    }

    class func emailTextFieldBorderColor() -> UIColor {
        let hex = "bdbdbd"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }

    class func PasswordTextFieldBorderColor() -> UIColor {
        let hex = "e0e0df"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }

    class func appThemeButtonColor() -> UIColor {
        let hex = "ee5e29"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }

    class func appThemeColor() -> UIColor {
        return #colorLiteral(red: 0.8878073096, green: 0.1544833779, blue: 0.5785527825, alpha: 1)
    }

    class func emailTextFiledPlaceHolderTextColor() -> UIColor {
        let hex = "b8b8b8"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }
    
    class func appToolBarColor() -> UIColor {
        let hex = "0596D5"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }

    class func textFieldTextColor() -> UIColor {
        let hex = "6f6f70"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }

    class func textFieldPlaceHolderColor() -> UIColor {
        let hex = "9a9999"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }

    class func notificationBackgroundColor() -> UIColor {
        let hex = "777677"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }

    class func jobsDateLabelColor() -> UIColor {
        let hex = "7f7f7f"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }

    class func jobsLabourLabelColor(with alpha: CGFloat) -> UIColor {
        let hex = "656666"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: alpha)
    }

    class func jobsCostLabelColor() -> UIColor {
        let hex = "59b95a"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }

    class func skillsTagsBackgroundColor() -> UIColor {
        let hex = "eeeceb"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }

    class func homeAddressColor() -> UIColor {
        let hex = "4d4d4e"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }

    class func jobsTabColor() -> UIColor {
        let hex = "b7b7b7"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }

    class func errorViewColor() -> UIColor {
        let hex = "f75543"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }
    
    class func switchThumbOnTintColor() -> UIColor {
        let hex = "f75543"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }
    
    class func switchThumbOffTintColor() -> UIColor {
        let hex = "f75543"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }
    
    class func greenStartButtonColor() -> UIColor {
        let hex = "0fd681"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }
    
    class func appThemePurpleColor() -> UIColor {
        let hex = "432F76"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: 1.0)
    }
    
    static var random: UIColor {
        
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
