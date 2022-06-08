//
//  DealGame.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation

struct DealGame {
    public var storeID: String = ""
    public var gameID: String = ""
    public var name: String = ""
    public var steamAppID: String? = nil
    public var salePrice: String = ""
    public var retailPrice: String = ""
    public var steamRatingText: String? = nil
    public var steamRatingPercent: String? = nil
    public var steamRatingCount: String? = nil
    public var metacriticScore: String = ""
    public var metacriticLink: String? = nil
    public var releaseDate: Date = Date()
    public var publisher: String = ""
    public var steamworks: String? = nil
    public var thumb: Data? = nil
}
