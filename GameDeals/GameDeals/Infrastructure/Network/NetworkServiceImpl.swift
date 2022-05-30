//
//  NetworkService.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

class NetworkServiceImpl: NetworkService {
    func get<T>(_ url: String, completionHandler: @escaping resultHandler<T>) where T : Decodable {
        fatalError("Not yet implemented")
    }
    
    func get<T>(_ url: String, queryParams: [String : String], completionHandler: @escaping resultHandler<T>) where T : Decodable {
        fatalError("Not yet implemented")
    }
    
    func post<T, BodyType>(_ url: String, body: BodyType, completionHandler: @escaping resultHandler<T>) where T : Decodable, BodyType : Encodable {
        fatalError("Not yet implemented")
    }
    
    func post<T, BodyType>(_ url: String, body: BodyType, queryParams: [String : String], completionHandler: @escaping resultHandler<T>) where T : Decodable, BodyType : Encodable {
        fatalError("Not yet implemented")
    }
    
    
}
