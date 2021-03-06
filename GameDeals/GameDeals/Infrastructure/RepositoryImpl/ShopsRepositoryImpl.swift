//
//  ShopsRepositoryImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 04.06.2022..
//

import Foundation

class ShopsRepositoryImpl: ShopsRepository {
    let networkDataSource: NetworkShopDS
    let dbDataSource: DbShopDS
    let networkShopMapper: Mapper<ShopNO, Shop>
    let dbShopMapper: Mapper<ShopMO, Shop>
    
    init(networkDS: NetworkShopDS,
         dbDS: DbShopDS,
         networkShopMapper: Mapper<ShopNO, Shop>,
         dbShopMapper: Mapper<ShopMO, Shop>) {
        self.networkDataSource = networkDS
        self.dbDataSource = dbDS
        self.networkShopMapper = networkShopMapper
        self.dbShopMapper = dbShopMapper
    }
    
    func getListOfShops(completionHandler: @escaping resultHandler<[Shop]>) {
        DispatchQueue.global(qos: .background).async {
            self.dbDataSource.getListOfShops(completionHandler: { result in
                if case let .success(value) = result {
                    completionHandler(.success(value.map { self.dbShopMapper.map($0) }.filter { $0.isActive != 0 }))
                }
                self.networkDataSource.getListOfShops(completionHandler: { result in
                    switch (result) {
                    case .success(let data):
                        self.dbDataSource.updateListOfShops(incomingShops: data.map{ self.networkShopMapper.map($0) }, completionHandler: { result in
                            if case .success(_) = result {
                                self.dbDataSource.getListOfShops(completionHandler: { result in
                                    if case let .success(value) = result {
                                        completionHandler(.success(value.map { self.dbShopMapper.map($0) }.filter { $0.isActive != 0 }))
                                    }
                                })
                            }
                        })
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                })
            })
        }
    }
    
}
