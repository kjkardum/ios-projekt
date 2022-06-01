//
//  DealMOMapper.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation

class DealMOMapper: Mapper<DealMO, Deal> {
    let dateService: DateTimeService
    init(dateService: DateTimeService) {
        self.dateService = dateService
    }
    
    override func mapTo(source: DealMO, destination: inout Deal) -> Deal {
        destination.internalName = source.internalName ?? ""
        destination.title = source.title ?? ""
        destination.metacriticLink = source.metacriticLink
        destination.dealID = source.dealId ?? ""
        destination.storeID = source.storeId ?? ""
        destination.gameID = source.gameId ?? ""
        destination.salePrice = source.salePrice ?? ""
        destination.normalPrice = source.normalPrice ?? ""
        destination.isOnSale = source.isOnSale ?? ""
        destination.savings = source.savings ?? ""
        destination.metacriticScore = source.metacriticScore ?? ""
        destination.steamRatingText = source.steamRatingText
        destination.steamRatingPercent = source.steamRatingPercent
        destination.steamRatingCount = source.steamRatingCount
        destination.steamAppID = source.steamAppId ?? ""
        destination.releaseDate = dateService.parse(Int(truncatingIfNeeded: source.releaseDate))
        destination.lastChange = dateService.parse(Int(truncatingIfNeeded: source.lastChange))
        destination.dealRating = source.dealRating ?? ""
        destination.thumb = source.thumb
        return destination
    }
    
    override func mapTo(source: Deal, destination: inout DealMO) -> DealMO {
        destination.internalName = source.internalName
        destination.title = source.title
        destination.metacriticLink = source.metacriticLink
        destination.dealId = source.dealID
        destination.storeId = source.storeID
        destination.gameId = source.gameID
        destination.salePrice = source.salePrice
        destination.normalPrice = source.normalPrice
        destination.isOnSale = source.isOnSale
        destination.savings = source.savings
        destination.metacriticScore = source.metacriticScore
        destination.steamRatingText = source.steamRatingText
        destination.steamRatingPercent = source.steamRatingPercent
        destination.steamRatingCount = source.steamRatingCount
        destination.steamAppId = source.steamAppID
        destination.releaseDate = Int64(dateService.toEpoch(source.releaseDate))
        destination.lastChange = Int64(dateService.toEpoch(source.lastChange))
        destination.dealRating = source.dealRating
        destination.thumb = source.thumb
        return destination
    }
    
    override func map(_ from: DealMO) -> Deal {
        var deal = Deal()
        return mapTo(source: from, destination: &deal)
    }
    
    override func map(_ from: Deal) -> DealMO {
        var dealMO = DealMO()
        return mapTo(source: from, destination: &dealMO)
    }
}
