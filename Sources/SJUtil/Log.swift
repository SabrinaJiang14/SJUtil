//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/15.
//

import Foundation

public enum Log {
    static public func debug<T>(_ message:T, file:String = #file, function:String = #function, line:Int = #line) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\n🐞 [DEBUG] [\(fileName)][\(function)][\(line)] : \(message)")
        #endif
    }
    
    static public func info<T>(_ message:T, file:String = #file, function:String = #function, line:Int = #line) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\n✅ [INFO] [\(fileName)][\(function)][\(line)] : \(message)")
        #endif
    }
    
    static public func error<T>(_ message:T, file:String = #file, function:String = #function, line:Int = #line) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\n‼️ [ERROR] [\(fileName)][\(function)][\(line)] : \(message)")
        #endif
    }
    
    static public func warning<T>(_ message:T, file:String = #file, function:String = #function, line:Int = #line) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\n⚠️ [WARNING] [\(fileName)][\(function)][\(line)] : \(message)")
        #endif
    }
}
