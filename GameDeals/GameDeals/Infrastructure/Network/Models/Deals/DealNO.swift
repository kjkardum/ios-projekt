//
//  Deal.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

struct DealNO: Codable {
    public var internalName: String
    public var title: String
    public var metacriticLink: String
    public var dealID: String
    public var storeID: String
    public var gameID: String
    public var salePrice: String
    public var normalPrice: String
    public var isOnSale: String
    public var savings: String
    public var metacriticScore: String
    public var steamRatingText: String?
    public var steamRatingPercent: String
    public var steamRatingCount: String
    public var steamAppID: String
    public var releaseDate: Int
    public var lastChange: Int
    public var dealRating: String
    public var thumb: String
}
