//
//  ListOfDealsParameters.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

struct ListOfDealsParameters {
    public var storeIds: [Int]? = nil
    public var pageNumber: Int = 0
    public var pageSize: Int = 60
    public var sortBy: GameSortingEnum = .dealRating
    public var desc: Bool = false
    public var lowerPrice: Int = 0
    public var upperPrice: Int = 50
    public var metacritic: Int? = nil
    public var steamRating: Int?
    public var steamAppID: [Int]?
    public var title: String?
    public var exact: Bool = false
    public var AAA: Bool = false
    public var steamworks: Bool = false
    public var onSale: Bool = false
}
