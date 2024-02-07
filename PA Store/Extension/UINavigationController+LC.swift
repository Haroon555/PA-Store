//
//  UINavigationController+LC.swift
//  HomeMedics
//
//  Created byDevBatch on 6/19/17.
//  Copyright © 2017DevBatch. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {

    func transparentNavigationBar() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.modalPresentationStyle = .fullScreen
        self.view.backgroundColor = .clear
    }

    func setAttributedTitle() {
        let attributes = [NSAttributedString.Key.font: UIFont.appThemeFontWithSize(19.0), NSAttributedString.Key.foregroundColor: UIColor.white] //change size as per your need here.
        self.navigationBar.titleTextAttributes = attributes
    }

    func setupAppThemeNavigationBar() {
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = #colorLiteral(red: 1, green: 0.7442570329, blue: 0, alpha: 1)
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
        else {
            navigationBar.setBackgroundImage(#imageLiteral(resourceName: "header"), for: .default)
        }
        
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .themeColor
        self.modalPresentationStyle = .fullScreen
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.appThemeBoldFontWithSize(20.0)]
    }
}
