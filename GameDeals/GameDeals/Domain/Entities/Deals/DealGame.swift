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
    public var steamAppID: String = ""
    public var salePrice: String = ""
    public var retailPrice: String = ""
    public var steamRatingText: String? = ""
    public var steamRatingPercent: String = ""
    public var steamRatingCount: String = ""
    public var metacriticScore: String = ""
    public var metacriticLink: String = ""
    public var releaseDate: Date = Date()
    public var publisher: String = ""
    public var steamworks: String = ""
    public var thumb: Data? = nil
}
