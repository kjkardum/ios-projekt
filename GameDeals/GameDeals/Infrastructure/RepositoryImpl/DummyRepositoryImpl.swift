//
//  DummyRepositoryImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

class DummyRepositoryImpl: DummyRepository {
    let networkDataSource: NetworkDummyDS
    let networkMapper: Mapper<DummyThingNO, DummyThing>
    
    init(networkDS: NetworkDummyDS,
         networkMapper: Mapper<DummyThingNO, DummyThing>) {
        self.networkDataSource = networkDS
        self.networkMapper = networkMapper
    }
    
    func getData() -> [DummyThing] {
        let data = networkDataSource.getData()
        return data.map { networkMapper.map($0) }
    }
    
}
