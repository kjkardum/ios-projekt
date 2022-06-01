//
//  DealMOMapper.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation

class DealMOMapper: Mapper<DealMO, Deal> {
    let dateService: DateTimeService
    init(dateService: DateTimeService) {
        self.dateService = dateService
    }
    
    override func mapTo(source: DealMO, destination: inout Deal) -> Deal {
        fatalError("Not yet implemented")
    }
    
    override func mapTo(source: Deal, destination: inout DealMO) -> DealMO {
        fatalError("Not yet implemented")
    }
    
    override func map(_: DealMO) -> Deal {
        fatalError("Not yet implemented")
    }
    
    override func map(_: Deal) -> DealMO {
        fatalError("Not yet implemented")
    }
}
