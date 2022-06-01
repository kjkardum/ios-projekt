//
//  DealsRepositoryImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 31.05.2022..
//

import Foundation

class DealsRepositoryImpl: DealsRepository {
    let networkDataSource: NetworkDealDS
    let networkDealMapper: Mapper<DealNO, Deal>
    let networkDetailedDealMapper: Mapper<DetailedDealNO, DetailedDeal>
    
    init(networkDS: NetworkDealDS,
         networkDealMapper: Mapper<DealNO, Deal>,
         networkDetailedDealMapper: Mapper<DetailedDealNO, DetailedDeal>) {
        self.networkDataSource = networkDS
        self.networkDealMapper = networkDealMapper
        self.networkDetailedDealMapper = networkDetailedDealMapper
    }
    
    func getListOfDeals(parameters: ListOfDealsParameters, completionHandler: @escaping resultHandler<[Deal]>) {
        networkDataSource.getListOfDeals(parameters: parameters, completionHandler: { result in
            switch (result) {
            case .success(let data):
                completionHandler(.success(data.map{ self.networkDealMapper.map($0) }))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
    
    func getDeal(id: String, completionHandler: @escaping resultHandler<DetailedDeal>) {
        networkDataSource.getDeal(id: id, completionHandler: { result in
            switch (result) {
            case .success(let data):
                completionHandler(.success(self.networkDetailedDealMapper.map(data)))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
}
