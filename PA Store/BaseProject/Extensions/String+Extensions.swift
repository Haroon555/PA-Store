//
//  String+Extensions.swift

import UIKit
//import MOLH

public extension String {
    
     func toDouble() -> Double? {
        return Double(self)
    }
    
     func toFloat() -> Float? {
        return Float(self)
    }
    
     func toInt() -> Int? {
        return Int(self)
    }
    
     func to12HourTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss "
        dateFormatter.locale = Locale(identifier: "en")
        //--ww dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    func toFormatedTime(_ format: String = "HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.date(from: self) ?? Date()
        return date
    }
    
    func toFormatedDate(_ format :String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(name: "en") as TimeZone?
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.date(from: self) ?? Date()
        return date
        
//        let dateFormatter = DateFormatter()
//        let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.locale = enUSPosixLocale
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss Z"
//        dateFormatter.calendar = Calendar(identifier: .gregorian)
//
//        let iso8601String = dateFormatter.date(from: self) ?? Date()
//        return iso8601String
    }
    
     func toFormatedDateString(_ format: String = "dd MMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en")
        //dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        //--ww dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = format
        dateFormatter.locale =  Locale(identifier: "en")
        return dateFormatter.string(from: date)
    }
    
     func toFormatedDateString(inFormat: String = "dd MMM yyyy", outformat: String = "dd MMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inFormat
        dateFormatter.locale = Locale(identifier: "en")
        //dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        //--ww dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = outformat
        dateFormatter.locale =  Locale(identifier: "en")
        return dateFormatter.string(from: date)
    }
    
     func toDateString(_ format: String = "dd MMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        //dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        //--ww dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
     func toDate(_ format: String = "yyyy-MM-dd") -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en")
        return dateFormatter.date(from: self) ?? Date()
    }
    
    func toDate2(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
    
    // MARK: - GET THE ROUND OFF VALUES
 
    
    /*   public var localized: String {
     // the; translators team, they don’t deserve comments
     return localoizedFromPlist.sharedInstance.localize(string: self)
     }
     */
    
    func isEmptyOrWhitespace() -> Bool {
        if(self.isEmpty) {
            return true
        }
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces) == ""
    }

    // Validate if the string is empty
     func isEmptyStr() -> Bool {
        return (self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "")
    }
    
     func isfirstIndex() -> Bool {
        return (self == "0")
    }
    
    // Validate if the email is correct
     func isValidEmail() -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return predicate.evaluate(with: self)
    }
    
    // Validate if the url is correct
     func isValidUrl() -> Bool {
        let regexURL: String = "(http://|https://)?((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regexURL)
        return predicate.evaluate(with: self)
    }
    
    // Validate if given input is numeric
     func isNumeric() -> Bool {
        return Double(self) != nil
    }
    
    // Validate if string has minimum characters
     func isValidForMinChar(noOfChar: Int) -> Bool {
        return (self.utf16.count >= noOfChar)
    }
    
    // Validate if string has less than or equal to maximum characters
     func isValidForMaxChar(noOfChar: Int) -> Bool {
        return (self.utf16.count <= noOfChar)
    }
    
    // Validate the string for given regex
     func isValidForRegex(regex: String) -> Bool {
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: self)
    }
    
    //extension for getting the domain name from a string
     func getDomain() -> String? {
        guard let url = URL(string: self) else { return nil }
        return url.host
    }
    
    var isAlphabetOnly: Bool {
        return !isEmpty && range(of: "[^a-zA-Z ]", options: .regularExpression) == nil
    }
    
    var isAlphanumeric: Bool {
        
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isContainSpecialCharacter: Bool {
        return !isEmpty && range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) == nil
    }
    
    var isContainsLetters: Bool {
        let letters = CharacterSet.letters
        return self.rangeOfCharacter(from: letters) != nil
    }
    
    var isContainNumbers: Bool {
        let decimalCharacters = CharacterSet.decimalDigits
        return self.rangeOfCharacter(from: decimalCharacters) != nil
    }
    
    var isContainsWhitespace: Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    

    
}
public class StringClass {
    
    static func trimStr(str: String) -> String {
        
        return str .trimmingCharacters(in: .whitespacesAndNewlines)
        
    }
    
    static func formatNumberAsCurrency(number: Int64) -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let str = numberFormatter .string(from: NSNumber(value: number))
        return str!
        
    }
    
    static func formatNumberAsCurrencyWithAddString(firstStr : String, number : Int64, lastStr: String) -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let noStr = numberFormatter .string(from: NSNumber(value: number))
        
        let str = firstStr + noStr! + lastStr
        return str
        
    }
    
    //    static func getAttributedStringForHTMLWithFont( htmlStr : String , textSize : Int , fontName : String )->NSAttributedString?
    //    {
    //        var htmlStr = htmlStr
    //        do {
    //
    //            if htmlStr .isEmpty{
    //                htmlStr = "<p></p>"
    //
    //            }
    //
    //            let str = "<div style=\"color:#5A5A5A; font-size: \(textSize)px\"><font face=\"\(fontName)\">\(htmlStr)</font></div>"
    //            let data  = str .data(using: String.Encoding.unicode)!
    //            let attributedOptions : [String: Any] = [
    //                NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
    //                NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
    //            ]
    //
    //
    //            let attributedStr = try NSAttributedString.init(data: data, options: attributedOptions, documentAttributes: nil)
    //            return attributedStr
    //        }
    //        catch {
    //            return nil
    //        }
    //    }
    
    static func sanitizeStr (str: String) -> String {
        
        let notAllowedCharacters = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+ ").inverted
        
        let resultSTR = str.components(separatedBy: notAllowedCharacters).joined(separator: "")
        
        debugPrint(resultSTR)
        
        return resultSTR
        
    }
    
    static func containSpecialChars(str: String) -> Bool {
        
        let notAllowedCharacters = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ").inverted
        
        let resultSTR = str.components(separatedBy: notAllowedCharacters).joined(separator: "")
        
        debugPrint(resultSTR)
        
        if resultSTR.count  == str.count {
            return false
        } else {
            return true
        }
        
    }
    
    static func containOnlyNumbers(str: String) -> Bool {
        let notAllowedCharacters = NSCharacterSet(charactersIn: "01234567890").inverted
        
        let resultSTR = str.components(separatedBy: notAllowedCharacters).joined(separator: "")
        
        debugPrint(resultSTR)
        
        if resultSTR.count  == str.count {
            return false
        } else {
            return true
        }
        
    }
   
    static func isEmptyString(str: String) -> Bool {
        
        let  string = str .trimmingCharacters(in: .whitespacesAndNewlines)
        return (string == "") ? true : false
        
    }
    
    static func stringWithoutWhitespaces(str: String) -> String {
        
        let words = str.components(separatedBy: .whitespacesAndNewlines)
        let nospacestring = words .joined(separator: "")
        return nospacestring
        
    }
}
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{ CharacterSet.decimalDigits.contains( $0 ) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func makePhoneCall() {
        if isValid(regex: .phone) {
            if let url = URL(string: "tel://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
}

extension String {
    var isBackspace: Bool {
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
}

extension Notification.Name {
    static let getUserId = Notification.Name("getUserId")
    static let updateUserData = Notification.Name("updateUserData")
    static let getProfileSegment = Notification.Name("getProfileSegment")
    static let getNewsFeed = Notification.Name("getNewsFeed")
    
    // video call
    static let roomUpdate = Notification.Name("RoomUpdate")
    static let participantUpdate = Notification.Name("ParticipantUpdate")
    static let participantsStoreUpdate = Notification.Name("ParticipantsStoreUpdate")
    static let mainParticipantStoreUpdate = Notification.Name("MainParticipantStoreUpdate")
    static let appSettingDidChange = Notification.Name("AppSettingDidChange")
}

extension String {
    
    func style(using style: AppTheme) -> NSMutableAttributedString {
        return  NSMutableAttributedString(string: self, attributes: style.attributes)
    }
    
}
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
}
extension String {

    public func stringURLEncode(plusForSpace: Bool=false) -> String? {
      let unreserved = "*-._://@"
      let allowed = NSMutableCharacterSet.alphanumeric()
      allowed.addCharacters(in: unreserved)

      if plusForSpace {
        allowed.addCharacters(in: " ")
      }

      var encoded = addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
      if plusForSpace {
        encoded = encoded?.replacingOccurrences(of: " ", with: "%20")
      }
      return encoded
    }
}
