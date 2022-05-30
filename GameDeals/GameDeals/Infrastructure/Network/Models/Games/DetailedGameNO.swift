//
//  DetailedGameNO.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

struct DetailedGameNO: Codable {
    public var info: GameInfoNO
    public var cheapestPriceEver: DealCheapestPriceNO
    public var deals: [GameDealNO]
}
