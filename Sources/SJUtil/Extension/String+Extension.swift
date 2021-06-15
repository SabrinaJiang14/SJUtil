//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/15.
//

import Foundation

/** For html */
public extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var toUTF8:String {
        return String(describing: self.cString(using: String.Encoding.utf8))
    }
}

/** For text size */
public extension String {
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}


/** For Date */
public extension String {
    func utcToLocal(dateFormat:String = "yyyy-MM-dd'T'HH:mm:ss.SSS+0000") -> String? {
        let utcFormatter = DateFormatter()
        utcFormatter.dateFormat = dateFormat
        if self.contains("Z") {
            utcFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        }
        utcFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let date = utcFormatter.date(from: self)
        
        if let dt = date {
            let localFormatter = DateFormatter()
            localFormatter.dateFormat = dateFormat
            localFormatter.timeZone = TimeZone.current
            return localFormatter.string(from: dt)
        }
        
        return nil
    }
    
    func localToUtc(dateFormat:String = "yyyy-MM-dd'T'HH:mm:ss'Z'") -> String? {
        let localFormatter = DateFormatter()
        localFormatter.dateFormat = dateFormat
        localFormatter.timeZone = TimeZone.current
        
        let date = localFormatter.date(from: self)
        
        if let dt = date {
            let utcFormatter = DateFormatter()
            utcFormatter.dateFormat = dateFormat
            utcFormatter.timeZone = TimeZone(abbreviation: "UTC")
            return utcFormatter.string(from: dt)
        }
        
        return nil
    }
    
    func toTaiwanDate(format:String) -> Date {
        let df = DateFormatter()
        df.dateFormat = format
        df.calendar = Calendar(identifier: .republicOfChina)
        let date = df.date(from: self)
        return date!
    }
    
    func toDate(dateFormat:String = "yyyy/MM/dd HH:mm:ss") -> Date {
        let format = DateFormatter()
        format.locale = .current
        format.dateFormat = dateFormat
        let date = format.date(from: self)
        return date!
    }
}

/** For codable */
public extension String {
    func urlEncoded() -> String {
        var chatSet = CharacterSet.urlQueryAllowed
        chatSet.remove(charactersIn: "=")
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: chatSet)
        return encodeUrlString ?? ""
    }
    
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}

/** For String table */
public extension String {
    func localized() -> String {
        let str = NSLocalizedString(self, comment: "")
        if str.count > 0 {
            return str
        }
        return self
    }
}

/** For SubString */
public extension String {
    func subString(from:Int, to:Int) -> String {
        guard from >= 0, to <= self.count else { return "" }
        let subStr = self[self.index(self.startIndex, offsetBy: from)...self.index(self.startIndex, offsetBy: to-1)]
        return String(subStr)
    }
}
