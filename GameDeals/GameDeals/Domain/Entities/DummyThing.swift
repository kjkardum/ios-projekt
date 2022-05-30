//
//  DummyThing.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

struct DummyThing {
    public var id: Int
    public var name: String
    public var lastRenamed: Date?
    public var type: String
    public var categoryId: Int?
    
    mutating func rename(name: String) {
        self.name = name
        self.lastRenamed = Date.now
    }
}
