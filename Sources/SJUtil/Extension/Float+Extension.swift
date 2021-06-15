//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/15.
//

import Foundation

public extension Int {
    func toDouble() -> Double { Double(self) }
    func toFloat() -> Float { Float(self) }
    func toString() -> String { String(self) }
}

public extension Double {
    func toInt() -> Int { Int(self) }
    func toFloat() -> Float { Float(self)}
    func toString() -> String { String(self) }
}

public extension Float {
    func toString() -> String { String(self) }
}
