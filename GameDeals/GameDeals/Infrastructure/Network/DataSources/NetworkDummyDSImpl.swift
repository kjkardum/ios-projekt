//
//  NetworkDummyDSImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

class NetworkDummyDSImpl: NetworkDummyDS {
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getData() -> [DummyThingNO] {
        return [DummyThingNO(identifier: 1, name: "Test", last_renamed: "2020/11/11 11:11", type: nil, category_id: 5)]
    }
}
