//
//  Storyboard.swift
//  PA Store
//
//  Created by Haroon Shoukat on 11/09/2023.
//

import Foundation
import UIKit

enum StoryBoard: String {
    case userAuthentication = "Main"
}

enum Constants {
    static let FILE_SIZE  = 0
    static let PLACEHOLDER_IMAGE_NAME = "imgplaceholder"
    static let minimumLengthName = 3
    static let maximumLengthName = 30
    static let maximumLengthNumber = 20
    static let minimumLengthNumber = 10
    static let maximumLengthText = 50
    static let minimumLengthPwd = 8
    static let maximumLengthPwd = 25
    static let maximumLengthTextView = 500
    static let networkSessionToken  = ""
    static let firstIndex = 0
}

enum AppColors {
    static let appTheme = "ThemePurple"
    static let pureOrange = "OrangeColor"
    static let liteOrange = "LiteOrange"
    static let lightPurple = "LightPurple"
    static let lightPink = "LightPink"
    static let otherMsgColor = "OtherMsg"
    static let myMsgColor = "MyMsg"
    static let SeletedCell = "SeletedCell"
    static let appThemePurple = "#453073"
    static let appThemeDisablePurple = "#A297B9"
    static let appOrangeCartColour = "#D65F7B"
    static let lightBrown = "#E8C0A8"
    static let appOrange = "#EA7F49"
    static let lightGray = "#DDDDDD"
    static let veryLightGray = "#E4EAF1"
    static let purple = "#D4BCE2"
    static let textViewGray = "#757776"
    static let litePink = "#F4D0D0"
    static let white = "#FFFFFF"
    static let red = "Red"
}

enum ImagesName {
    static let ScanProduct = "barcode_new"
    static let HighValueCount = "high_count"
    static let Service = "calendar_month"
    static let Service1 = "downArrow"
    static let Service2 = "downArrow"
    static let downArrow = "expand_more"
}
