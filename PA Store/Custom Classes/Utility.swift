//
//  Utility.swift
//  PA Store
//
//  Created by Haroon Shoukat on 22/09/2023.
//

import Foundation
import UIKit
import Alamofire

class Utility: NSObject{
    class func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    class func attributedTitle(firstTitle: String, secondTitle: String, fontSize: CGFloat = 20.0) -> NSAttributedString {
        
        let firstAttributedTitle = [
            NSAttributedString.Key.font: UIFont.appThemeFontWithSize(fontSize),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        let secondAttributedTitle = [
            NSAttributedString.Key.font: UIFont.appThemeBoldFontWithSize(fontSize),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        let firstattrStr = NSMutableAttributedString(string: firstTitle, attributes: firstAttributedTitle)
        let secondAttrStr =  NSMutableAttributedString(string: secondTitle, attributes: secondAttributedTitle)
        
        firstattrStr.append(secondAttrStr)
        return firstattrStr
    }

    class func attributedTitleWithFirstBold(firstTitle: String, secondTitle: String) -> NSAttributedString {
        let firstAttributedTitle = [
            NSAttributedString.Key.font: UIFont.appThemeBoldFontWithSize(20.0),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        let secondAttributedTitle = [
            NSAttributedString.Key.font: UIFont.appThemeFontWithSize(20.0),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        let firstattrStr = NSMutableAttributedString(string: firstTitle, attributes: firstAttributedTitle)
        let secondAttrStr =  NSMutableAttributedString(string: secondTitle, attributes: secondAttributedTitle)
        
        firstattrStr.append(secondAttrStr)
        return firstattrStr
    }
    
    
    //MARK: - Convert Dict in JSON
    
    class func convertDictInJson(_ dict: [String: AnyObject]) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .ascii) {
                return jsonString
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
        return ""
    }
    
    class func saveCookies(response: DataResponse<Any>) {
        
        if let headerFields = response.response?.allHeaderFields as? [String: String] {
            let url = response.response?.url
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url!)
            var cookieArray = [[HTTPCookiePropertyKey: Any]]()
            for cookie in cookies {
                cookieArray.append(cookie.properties!)
            }
            UserDefaults.standard.set(cookieArray, forKey: kSavedCookies)
            UserDefaults.standard.synchronize()
        }
    }

    
    class func loadCookies() {
        guard let cookieArray = UserDefaults.standard.array(forKey: kSavedCookies) as? [[HTTPCookiePropertyKey: Any]] else { return }
        for cookieProperties in cookieArray {
            if let cookie = HTTPCookie(properties: cookieProperties) {
                HTTPCookieStorage.shared.setCookie(cookie)
            }
        }
    }
    
    class func removedCookies() {
        UserDefaults.standard.removeObject(forKey: kSavedCookies)
        UserDefaults.standard.synchronize()
    }
}
