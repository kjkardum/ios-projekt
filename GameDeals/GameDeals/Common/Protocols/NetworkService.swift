//
//  NetworkService.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

protocol NetworkService {
    
    func get<T: Decodable>(_ url: String, completionHandler: @escaping resultHandler<T>)
    
    func get<T: Decodable>(_ url: String, queryParams: [String : String], completionHandler: @escaping resultHandler<T>)
    
    func post<T: Decodable, BodyType>(_ url: String, body: BodyType, completionHandler: @escaping resultHandler<T>) where BodyType: Encodable
    
    func post<T: Decodable, BodyType>(_ url: String, body: BodyType, queryParams: [String : String], completionHandler: @escaping resultHandler<T>) where BodyType: Encodable
    
}
