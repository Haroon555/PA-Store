//
//  UIColor.swift
//  PA Store
//
//  Created by Haroon Shoukat on 13/09/2023.
//

import Foundation
import UIKit

extension UIColor {
    
    @nonobjc class var bgWhite: UIColor {
        return UIColor(white: 246.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var themeColor: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 193.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var blackText: UIColor {
        return UIColor(red: 29.0 / 255.0, green: 29.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lightGreyText: UIColor {
        return UIColor(red: 117 / 255.0, green: 119 / 255.0, blue: 118 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var white: UIColor {
        return UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)
    }
    
    @nonobjc class var liteThemeColor: UIColor {
        return UIColor(red: 0.635, green: 0.592, blue: 0.725, alpha: 1.0)
        
    }
    @nonobjc class var orange: UIColor {
        return UIColor(red: 0.918, green: 0.498, blue: 0.286, alpha: 1)
        
    }
    @nonobjc class var orangeDisabled: UIColor {
        return UIColor(red: 0.918, green: 0.498, blue: 0.286, alpha: 0.5)
        
    }
    @nonobjc class var disabledGrey: UIColor {
        return UIColor(red: 0.867, green: 0.867, blue: 0.867, alpha: 1)
        
    }
    @nonobjc class var disabledButtonPurple: UIColor {
        return UIColor(red: 247.0, green: 224.0, blue: 147.0, alpha: 1)
        
    }
    @nonobjc class var clearColor: UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
    }
    
}
