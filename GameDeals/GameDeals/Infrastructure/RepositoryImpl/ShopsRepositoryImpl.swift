//
//  ShopsRepositoryImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 04.06.2022..
//

import Foundation

class ShopsRepositoryImpl: ShopsRepository {
    let networkDataSource: NetworkShopDS
    let networkShopMapper: Mapper<ShopNO, Shop>
    
    init(networkDS: NetworkShopDS,
         networkShopMapper: Mapper<ShopNO, Shop>) {
        self.networkDataSource = networkDS
        self.networkShopMapper = networkShopMapper
    }
    
    func getListOfShops(completionHandler: @escaping resultHandler<[Shop]>) {
        networkDataSource.getListOfShops(completionHandler: { result in
            switch (result) {
            case .success(let data):
                completionHandler(.success(data.map{ self.networkShopMapper.map($0) }))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
    
}
