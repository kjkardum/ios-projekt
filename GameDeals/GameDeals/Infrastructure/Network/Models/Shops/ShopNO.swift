//
//  ShopNO.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 04.06.2022..
//

import Foundation

struct ShopNO: Codable {
    public var storeID: String = ""
    public var storeName: String = ""
    public var isActive: Int = 0
    public var images: ShopImageNO = ShopImageNO()
}
