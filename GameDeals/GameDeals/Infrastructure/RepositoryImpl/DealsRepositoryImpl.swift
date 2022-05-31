//
//  DealsRepositoryImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 31.05.2022..
//

import Foundation

class DealsRepositoryImpl: DealsRepository {
    let networkDataSource: NetworkDealDS
    let networkMapper: Mapper<DealNO, Deal>
    
    init(networkDS: NetworkDealDS,
         networkMapper: Mapper<DealNO, Deal>) {
        self.networkDataSource = networkDS
        self.networkMapper = networkMapper
    }
    
    func getListOfDeals(parameters: ListOfDealsParameters, completionHandler: @escaping resultHandler<[Deal]>) {
        networkDataSource.getListOfDeals(parameters: parameters, completionHandler: { result in
            switch (result) {
            case .success(let data):
                completionHandler(.success(data.map{ self.networkMapper.map($0) }))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
}
