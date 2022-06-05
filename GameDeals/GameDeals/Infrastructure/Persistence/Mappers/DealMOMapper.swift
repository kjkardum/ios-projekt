//
//  DealMOMapper.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation
import CoreData

class DealMOMapper: Mapper<DealMO, Deal> {
    let dateService: DateTimeService
    let context: NSManagedObjectContext
    init(dateService: DateTimeService, coreDataStack: CoreDataStack) {
        self.dateService = dateService
        self.context = coreDataStack.persistentContainer.viewContext
    }
    
    override func mapTo(source: DealMO, destination: inout Deal) -> Deal {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        
        destination.internalName = source.internalName ?? ""
        destination.title = source.title ?? ""
        destination.metacriticLink = source.metacriticLink
        destination.dealID = source.dealId ?? ""
        destination.storeID = Int(truncatingIfNeeded: source.storeId)
        destination.gameID = source.gameId ?? ""
        destination.salePrice = formatter.string(from: source.salePrice ?? 0) ?? "0.00"
        destination.normalPrice = formatter.string(from: source.normalPrice ?? 0) ?? "0.00"
        destination.isOnSale = source.isOnSale ?? ""
        destination.savings = source.savings ?? ""
        destination.metacriticScore = Int(truncatingIfNeeded: source.metacriticScore)
        destination.steamRatingText = source.steamRatingText
        destination.steamRatingPercent = Int(truncatingIfNeeded: source.steamRatingPercent)
        destination.steamRatingCount = source.steamRatingCount
        destination.steamAppID = Int(truncatingIfNeeded: source.steamAppId)
        destination.releaseDate = dateService.parse(Int(truncatingIfNeeded: source.releaseDate))
        destination.lastChange = dateService.parse(Int(truncatingIfNeeded: source.lastChange))
        destination.dealRating = String(source.dealRating)
        destination.thumb = source.thumb
        return destination
    }
    
    override func mapTo(source: Deal, destination: inout DealMO) -> DealMO {
        destination.internalName = source.internalName
        destination.title = source.title
        destination.metacriticLink = source.metacriticLink
        destination.dealId = source.dealID
        destination.storeId = Int64(source.storeID)
        destination.gameId = source.gameID
        destination.salePrice = NSDecimalNumber(string: source.salePrice)
        destination.normalPrice = NSDecimalNumber(string: source.normalPrice)
        destination.isOnSale = source.isOnSale
        destination.savings = source.savings
        destination.metacriticScore = Int64(source.metacriticScore)
        destination.steamRatingText = source.steamRatingText
        destination.steamRatingPercent = Int64(source.steamRatingPercent ?? 0)
        destination.steamRatingCount = source.steamRatingCount
        destination.steamAppId = Int64(source.steamAppID ?? 0)
        destination.releaseDate = Int64(dateService.toEpoch(source.releaseDate))
        destination.lastChange = Int64(dateService.toEpoch(source.lastChange))
        destination.dealRating = Double(source.dealRating) ?? 0
        destination.thumb = source.thumb
        return destination
    }
    
    override func map(_ from: DealMO) -> Deal {
        var deal = Deal()
        return mapTo(source: from, destination: &deal)
    }
    
    override func map(_ from: Deal) -> DealMO {
        var dealMO = DealMO(context: context)
        return mapTo(source: from, destination: &dealMO)
    }
}
