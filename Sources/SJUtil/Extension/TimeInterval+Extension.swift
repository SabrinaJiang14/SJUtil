//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/15.
//

import Foundation

public extension TimeInterval {
    
    func toFormatString(dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String? {
        let df = DateFormatter()
        let timeZone = TimeZone.current.identifier
        df.timeZone = TimeZone(identifier: timeZone)
        let date = Date(timeIntervalSince1970: self)
        df.dateFormat = dateFormat
        return df.string(from: date)
    }
    
    var hourToSecond: String {
        String(format:"%03d：%02d：%02d", hour, minute, second)
    }
    var hourToMillisecond: String {
        String(format:"%03d：%02d：%02d.%03d", hour, minute, second, millisecond)
    }
    var minuteToMillisecond: String {
        String(format:"%03d：%02d.%03d", minute, second, millisecond)
    }
    var hour: Int {
        Int((self/3600).truncatingRemainder(dividingBy: 3600))
    }
    var minute: Int {
        Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}
