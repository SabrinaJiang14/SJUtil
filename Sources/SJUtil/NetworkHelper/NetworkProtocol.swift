//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/15.
//

import Foundation

public enum HttpMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public enum ParametersEncoding {
    case DefaultEncoding
    case UrlEnconing
    case BodyEncoding
}

public enum MimeType:String {
    case Image = "image/jpeg"
    case Audio = "audio/mpeg3"
}

public enum Results<T> {
    case success(T)
    case error(Error)
}

public protocol NetworkProtocol {
    func request(_ url:URL, method: HttpMethod, parameters: [String: Any]?, timeoutInterval: TimeInterval, encoding: ParametersEncoding?, headers: [String: String]?, completion: @escaping (Results<Json>) -> Void)
    
    func requestWithAuth(_ url:URL, method: HttpMethod, parameters: [String: Any]?, headers: [String: String]?, userName:String, userPassword:String, completion: @escaping (Results<Json>) -> Void)
    
    func requestWithUploadFileNotInBody(_ url:URL, method: HttpMethod, parameters: [String: Any]?, mData:Data, mimeType:MimeType, fileName:String, timeoutInterval: TimeInterval, encoding: ParametersEncoding?, headers: [String: String]?, completion: @escaping (Results<Json>) -> Void)
    
    func requestWithUploadFileInBody(_ url:URL, method: HttpMethod, parameters: [String: Any]?, mData:Data, mimeType:MimeType, fileName:String, timeoutInterval: TimeInterval, encoding: ParametersEncoding?, headers: [String: String]?, completion: @escaping (Results<Json>) -> Void)
    
    func requestWithUploadFilesInBody(_ url:URL, method: HttpMethod, parameters: [String: Any]?, files:[Data], fileExtension:String, mimeType:MimeType, timeoutInterval: TimeInterval, encoding: ParametersEncoding?, headers: [String: String]?, completion: @escaping (Results<Json>) -> Void)
    
    func requestImage(_ url:URL, completed: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void))
}

extension NetworkProtocol {
    func requestWithAuth(
        _ url:URL,
        method: HttpMethod,
        parameters: [String: Any]?,
        headers: [String: String]?,
        userName:String,
        userPassword:String,
        completion: @escaping (Results<Json>) -> Void) { }
}

public enum Json {
    case object(_: JsonObject)
    case array(_: [JsonObject])
    
    public init?(json: Any) {
        if let object = json as? JsonObject {
            self = .object(object)
            return
        }
        
        if let array = json as? [JsonObject] {
            self = .array(array)
            return
        }
        
        return nil
    }
}
