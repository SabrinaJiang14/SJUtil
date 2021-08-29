//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/15.
//

import Foundation

public protocol DatabaseProtocol {
    func loadFromDB<T:JSONCodable>(completed:((T) -> Void))
//    func queryObjectById<T : JSONCodable>(objectId:String) -> Just<T>
//    func updateObject<T: JSONCodable>(object:T) -> Future<Void, Never>
//    func updateObjects<T: JSONCodable>(objects:[T]) -> Future<Void, Never>
//    func deleteForAll() -> Future<Void, Never>
//    func deleteDbByObject<T: JSONCodable>(object:T) -> Future<Void, Never>
//    func deleteForOne<T : JSONCodable>(object:T, uid:String) -> Future<Void, Never>
    func getDBSize() -> Double
}
