//
//  NetworkShopDSImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 04.06.2022..
//

import Foundation

class NetworkShopDSImpl: NetworkShopDS {
    let BASE_URL = "https://www.cheapshark.com/api/1.0"
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getListOfShops(completionHandler: @escaping resultHandler<[ShopNO]>) {
        networkService.get(BASE_URL + "/stores", completionHandler: completionHandler)
    }
}
