//
//  DealsRepositoryImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 31.05.2022..
//

import Foundation

class DealsRepositoryImpl: DealsRepository {
    let networkDataSource: NetworkDealDS
    let dbDataSource: DbDealDS
    let networkDealMapper: Mapper<DealNO, Deal>
    let dbDealMapper: Mapper<DealMO, Deal>
    let networkDetailedDealMapper: Mapper<DetailedDealNO, DetailedDeal>
    
    init(networkDS: NetworkDealDS,
         dbDS: DbDealDS,
         networkDealMapper: Mapper<DealNO, Deal>,
         dbDealMapper: Mapper<DealMO, Deal>,
         networkDetailedDealMapper: Mapper<DetailedDealNO, DetailedDeal>) {
        self.networkDataSource = networkDS
        self.dbDataSource = dbDS
        self.networkDealMapper = networkDealMapper
        self.dbDealMapper = dbDealMapper
        self.networkDetailedDealMapper = networkDetailedDealMapper
    }
    
    func getListOfDeals(parameters: ListOfDealsParameters, completionHandler: @escaping resultHandler<[Deal]>) {
        DispatchQueue.global(qos: .background).async {
            self.dbDataSource.getListOfDeals(parameters: parameters, completionHandler: { result in
                if case let .success(value) = result {
                    completionHandler(.success(value.map { self.dbDealMapper.map($0) }))
                }
                self.networkDataSource.getListOfDeals(parameters: parameters, completionHandler: { result in
                    switch (result) {
                    case .success(let data):
                        //completionHandler(.success(data.map{ self.networkDealMapper.map($0) }))
                        self.dbDataSource.updateListOfDeals(parameters: parameters, incomingDeals: data.map{ self.networkDealMapper.map($0) }, completionHandler: { result in
                            self.dbDataSource.getListOfDeals(parameters: parameters, completionHandler: { result in
                                if case let .success(value) = result {
                                    completionHandler(.success(value.map { self.dbDealMapper.map($0) }))
                                }
                            })
                        })
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                })
            })
        }
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
