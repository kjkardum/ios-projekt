//
//  Deal.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 31.05.2022..
//

import Foundation

struct Deal {
    public var internalName: String = ""
    public var title: String = ""
    public var metacriticLink: String? = nil
    public var dealID: String = ""
    public var storeID: Int = 0
    public var gameID: String = ""
    public var salePrice: String = ""
    public var normalPrice: String = ""
    public var isOnSale: String = ""
    public var savings: String = ""
    public var metacriticScore: Int = 0
    public var steamRatingText: String? = nil
    public var steamRatingPercent: Int? = nil
    public var steamRatingCount: String? = nil
    public var steamAppID: Int? = nil
    public var releaseDate: Date = Date()
    public var lastChange: Date = Date()
    public var dealRating: String = ""
    public var thumb: Data? = nil
}
