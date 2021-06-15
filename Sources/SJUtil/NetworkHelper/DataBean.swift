//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/15.
//

import Foundation

public struct DataBean<R:JSONCodable> : JSONCodable {
    public let msg:String?
    public let code:Int?
    public let success:Bool
    public let accessToken:String?
    public let content:DataBeanContent<R>?
}

public enum DataBeanContent<T:JSONCodable> : JSONCodable {
    case object(T)
    case array(Array<T>)
    case none

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let obj = try? container.decode(T.self) {
            self = .object(obj)
            return
        }else if let arr = try? container.decode([T].self) {
            self = .array(arr)
            return
        }else{
            self = .none
        }
        throw DecodingError.typeMismatch(DataBeanContent.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DataBeanContent"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .object(let x):
            try container.encode(x)
        case .array(let arr):
            try container.encode(arr)
        case .none:
            throw EncodingError.invalidValue(DataBeanContent.self, EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "Wrong type for DataBeanContent"))
        }
    }
}
