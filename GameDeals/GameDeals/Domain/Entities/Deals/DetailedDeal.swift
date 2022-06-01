//
//  DetailedDeal.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation

struct DetailedDeal {
    public var gameInfo: DealGame = DealGame()
    public var cheaperStores: [DealCheaperStore] = []
    public var cheapestPrice: DealCheapestPrice = DealCheapestPrice()
}
