//
//  DetailedDealNO.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

struct DetailedDealNO: Codable {
    public var gameInfo: DealGameNO
    public var cheaperStores: [DealCheaperStoreNO]
    public var cheapestPrice: DealCheapestPriceNO
}
