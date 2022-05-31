//
//  NetworkDealDSImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 31.05.2022..
//

import Foundation

class NetworkDealDSImpl: NetworkDealDS {
    let BASE_URL = "https://www.cheapshark.com/api/1.0"
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    func getListOfDeals(parameters: ListOfDealsParameters, completionHandler: @escaping resultHandler<[DealNO]>) {
        let paramsDict = parameters.convertToParamsDictionary()
        networkService.get(BASE_URL + "/deals", queryParams: paramsDict, completionHandler: completionHandler)
    }
    
    func getDeal(id: String, completionHandler: @escaping resultHandler<DetailedDealNO>) {
        let paramsDict = ["id" : String(id)]
        networkService.get(BASE_URL + "/deals", queryParams: paramsDict, completionHandler: completionHandler)
    }
    
    
}
