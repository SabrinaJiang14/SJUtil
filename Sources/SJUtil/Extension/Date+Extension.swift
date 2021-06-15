//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/15.
//

import Foundation

public extension Date {
    
    func toString(dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String? {
        let df = DateFormatter()
        df.dateFormat = dateFormat
        let timeZone = TimeZone.current.identifier
        df.timeZone = TimeZone(identifier: timeZone)
        return df.string(from: self)
    }
    
    static func - (lhs:Date, rhs:Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
