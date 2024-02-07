//
//  MotoryTheme.swift
// SetPoint
//
//  Created by Saad Ali on 16/11/2020.
//  Copyright © 2020 Next Generation Innovation. All rights reserved.
//

import Foundation
import UIKit

enum AppFonts {
    case syneBold(engSize: CGFloat)
    case syneSemiBold(engSize: CGFloat)
    case syneMedium(engSize: CGFloat)
    case syneRegular(engSize: CGFloat)
    case ovoRegular(engSize: CGFloat)
    func getFont() -> UIFont? {
        
        
        switch self {
        case .syneBold(engSize: let engSize):
            return UIFont(name: "Poppins-Bold", size: engSize)
        case .syneSemiBold(engSize: let engSize):
            return  UIFont(name: "Poppins-SemiBold", size: engSize)
        case .syneMedium(engSize: let engSize):
            return UIFont(name: "Poppins-Medium", size: engSize)
        case .syneRegular(engSize: let engSize):
            return UIFont(name: "Poppins-Regular", size: engSize)
        case .ovoRegular(engSize: let engSize):
            return  UIFont(name: "Ovo", size: engSize)
        }
    }
}
