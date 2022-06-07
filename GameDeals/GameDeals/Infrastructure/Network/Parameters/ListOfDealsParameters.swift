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

extension ListOfDealsParameters {
    func convertToParamsDictionary() -> [String : String] {
        var params: [String : String] = [:]
        if let storeIds = storeIds {
            params["storeID"] = storeIds.map({ String($0) }).joined(separator: ",")
        }
        params["pageNumber"] = String(pageNumber)
        params["pageSize"] = String(pageSize)
        params["sortBy"] = sortBy.rawValue
        params["desc"] = desc ? "1" : "0"
        params["lowerPrice"] = String(lowerPrice)
        params["upperPrice"] = String(upperPrice)
        if let metacritic = metacritic {
            params["metacritic"] = String(metacritic)
        }
        if let steamRating = steamRating {
            params["steamRating"] = String(steamRating)
        }
        if let steamAppID = steamAppID {
            params["steamAppID"] = steamAppID.map({ String($0) }).joined(separator: ",")
        }
        if let title = title {
            params["title"] = title
        }
        params["exact"] = exact ? "1" : "0"
        params["AAA"] = AAA ? "1" : "0"
        params["steamworks"] = steamworks ? "1" : "0"
        params["onSale"] = onSale ? "1" : "0"
        return params
    }
}
