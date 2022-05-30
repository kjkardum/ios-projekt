//
//  DummyThingNetworkMapper.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

class DummyThingNOMapper: Mapper<DummyThingNO, DummyThing> {
    override func map(_ from: DummyThingNO) -> DummyThing {
        var to = DummyThing(id: 0, name: "", type: "")
        return mapTo(source: from, destination: &to)
    }
    
    override func map(_ from: DummyThing) -> DummyThingNO {
        var to = DummyThingNO(identifier: 0)
        return mapTo(source: from, destination: &to)
    }
    
    override func mapTo(source: DummyThingNO, destination: inout DummyThing) -> DummyThing {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        destination.id = source.identifier
        destination.name = source.name ?? ""
        destination.type = source.type ?? ""
        destination.lastRenamed = formatter.date(from: source.last_renamed ?? "")
        destination.categoryId = source.category_id
        return destination
    }
    
    override func mapTo(source: DummyThing, destination: inout DummyThingNO) -> DummyThingNO {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        destination.identifier = source.id
        destination.name = source.name
        destination.type = source.type
        destination.last_renamed = source.lastRenamed != nil ? formatter.string(from: source.lastRenamed!) : nil
        destination.category_id = source.categoryId
        return destination
    }
    
}
