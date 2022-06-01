//
//  NetworkGameDSImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation

class NetworkGameDSImpl: NetworkGameDS {
    let BASE_URL = "https://www.cheapshark.com/api/1.0"
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    func getListOfGames(title: String, exact: Bool, steamAppId: Int?, limit: Int?, completionHandler: @escaping resultHandler<[GameNO]>) {
        var paramsDict = [
            "title" : title,
            "exact" : exact ? "1" : "0"
        ]
        if let steamAppId = steamAppId {
            paramsDict["steamAppId"] = String(steamAppId)
        }
        if let limit = limit {
            paramsDict["limit"] = String(limit)
        }
        networkService.get(BASE_URL + "/games", queryParams: paramsDict, completionHandler: completionHandler)
    }
    
    func getGame(id: Int, completionHandler: @escaping resultHandler<DetailedGameNO>) {
        let paramsDict = ["id" : String(id)]
        networkService.get(BASE_URL + "/games", queryParams: paramsDict, completionHandler: completionHandler)
    }
    
}
