//
//  DummyThingNO.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

//NO je NetworkObject, ako imate bolju kraticu za network DTO, izmjenite, mozda NDTO ili samo DTO
struct DummyThingNO: Codable {
    public var identifier: Int
    public var name: String?
    public var last_renamed: String?
    public var type: String?
    public var category_id: Int?
}
