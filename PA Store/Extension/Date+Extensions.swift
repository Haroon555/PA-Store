//
//  Date+Extensions.swift


import UIKit
import AVFoundation

extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.locale = Locale(identifier:"en")
        return dateFormatter.string(from: self)
    }
    
    func toString(_ withCustomeFormat: String? = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"en")
        dateFormatter.dateFormat = withCustomeFormat
        return dateFormatter.string(from: self)
    }

    func timeAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("HH:mm:ss")
        return df.string(from: self)
    }
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    func monthNameAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("MMMM")
        return df.string(from: self)
    }
    
    func dayAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("EEE")
        return df.string(from: self)
    }
    
    func dayFullNameAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("EEEE")
        return df.string(from: self)
    }
    
    func dateAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("dd")
        return df.string(from: self)
    }
    
    func dateWMonthAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("dd , MMM")
        return df.string(from: self)
    }
    
    func yearAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("yyyy")
        return df.string(from: self)
    }
    
    func monthAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("MM")
        return df.string(from: self)
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func incrementDays(numberOfDays: Int) -> Date {
        let date = Calendar.current.date(byAdding: .day, value: numberOfDays, to: self)
        return date!
    }
    
    func incrementMonths(numberOfMonths: Int) -> Date {
        let date = Calendar.current.date(byAdding: .month, value: numberOfMonths, to: self)
        return date!
    }
    
    func get12HoursFormateTime(_ time: String) -> String {
        
        let dateAsString = time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "h:mm a"
        let Date12 = dateFormatter.string(from: date ?? Date())
        return Date12
    }
    
    func dateFromString(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en")
        formatter.timeZone = TimeZone.current
        let result = formatter.date(from: self.toString("yyyy-MM-dd HH:mm:ss"))
        return result
    }
    
     func toDateWithZeroTime(dateString: String) -> Date {
        
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
         dateFormatter.calendar = Calendar(identifier: .gregorian)
         dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
         dateFormatter.locale = Locale(identifier: "en_US_POSIX")
         if let dateFromString = dateFormatter.date(from: dateString.components(separatedBy: " ").first ?? "") {
            return dateFromString  
         }
         return Date()
     }
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    func dateFormatWithSuffix(formate: String = "MMMM") -> String {
        return "dd'\(self.daySuffix())' \(formate), yyyy"
    }

    func daySuffix() -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: self)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
}

//extension String {
//    
//    func convertDateFormater(date: String, inFormat: String, outFormat: String) -> String {
//        printNgi(date)
//        let dateFormatter = DateFormatter()
//        if currentLanguage() == .urdu {
//            dateFormatter.locale = Locale(identifier: "ur_PK")
//            dateFormatter.amSymbol = "AM"
//            dateFormatter.pmSymbol = "PM"
//        }
//        dateFormatter.dateFormat = inFormat
//        let date = dateFormatter.date(from: date)
//        printNgi(date)
//        dateFormatter.dateFormat = outFormat
//        printNgi(dateFormatter.string(from: date ?? Date()))
//        return  dateFormatter.string(from: date ?? Date())
//    }
//    
//    func UTCToLocal(date:String, inFormat: String = "yyyy-MM-dd HH:mm:ss", outFormat: String) -> String {
//        let dateFormatter = DateFormatter()
//        if currentLanguage() == .urdu {
//            dateFormatter.locale = Locale(identifier: "ur_PK")
//            dateFormatter.amSymbol = "AM"
//            dateFormatter.pmSymbol = "PM"
//        }
//        dateFormatter.dateFormat = inFormat
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        let dt = dateFormatter.date(from: date)
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateFormat = outFormat
//        return dateFormatter.string(from: dt ?? Date())
//    }
//    
//    func UTCToLocalWithNoTime(date: String, inFormat: String = "yyyy-MM-dd HH:mm:ss", outFormat: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en")
//        dateFormatter.dateFormat = inFormat
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        let dt = dateFormatter.date(from: date)
//        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
//        dateFormatter.dateFormat = outFormat
//        return dateFormatter.string(from: dt ?? Date())
//    }
//    
//    func convertStringToDate(inFormat: String? = "yyyy-MM-dd HH:mm:ss", outFormat: String? = "yyyy-MM-dd HH:mm:ss") -> Date? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en")
//        dateFormatter.dateFormat = outFormat
//        let date = dateFormatter.date(from: self)
//        return date
//    }
//    
//    func getDate() -> Date? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateFormatter.locale = Locale(identifier: "en")
//        dateFormatter.timeZone = TimeZone.current
//        return dateFormatter.date(from: self)
//    }
//    
//    func toLengthOf(length: Int) -> String {
//        if length <= 0 {
//            return self
//        } else if let to = self.index(self.startIndex, offsetBy: length, limitedBy: self.endIndex) {
//            return self.substring(from: to)
//        } else {
//            return ""
//        }
//    }
//    
//    func stringToImage(_ handler: @escaping ((UIImage?) -> Void )) {
//      if let url = URL(string: self) {
//        URLSession.shared.dataTask(with: url) { (data, _ response, _ error) in
//          if let data = data {
//            let image = UIImage(data: data)
//            handler(image)
//          }
//        }.resume()
//      }
//    }
//    
//    func toInt() -> Int {
//        return Int(self) ?? 0
//    }
//    
//}
