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
    public var storeID: String = ""
    public var gameID: String = ""
    public var salePrice: String = ""
    public var normalPrice: String = ""
    public var isOnSale: String = ""
    public var savings: String = ""
    public var metacriticScore: String = ""
    public var steamRatingText: String? = nil
    public var steamRatingPercent: String? = nil
    public var steamRatingCount: String? = nil
    public var steamAppID: String? = nil
    public var releaseDate: Int = 0
    public var lastChange: Int = 0
    public var dealRating: String = ""
    public var thumb: Data? = nil
}
