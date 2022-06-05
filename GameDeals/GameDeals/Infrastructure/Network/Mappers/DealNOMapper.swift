//
//  DealNOMapper.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 31.05.2022..
//

import UIKit

class DealNOMapper: Mapper<DealNO, Deal> {
    let dateService: DateTimeService
    init(dateService: DateTimeService) {
        self.dateService = dateService
    }
    
    override func mapTo(source: DealNO, destination: inout Deal) -> Deal {
        destination.internalName = source.internalName
        destination.title = source.title
        destination.metacriticLink = source.metacriticLink
        destination.dealID = source.dealID
        destination.storeID = Int(source.storeID) ?? 0
        destination.gameID = source.gameID
        destination.salePrice = source.salePrice
        destination.normalPrice = source.normalPrice
        destination.isOnSale = source.isOnSale
        destination.savings = source.savings
        destination.metacriticScore = Int(source.metacriticScore) ?? 0
        destination.steamRatingText = source.steamRatingText
        destination.steamRatingPercent = Int(source.steamRatingPercent ?? "nil")
        destination.steamRatingCount = source.steamRatingCount
        destination.steamAppID = Int(source.steamAppID ?? "nil")
        destination.releaseDate = dateService.parse(source.releaseDate)
        destination.lastChange = dateService.parse(source.lastChange)
        destination.dealRating = source.dealRating
        
        let betterSource = source.thumb.replacingOccurrences(of: "capsule_sm_120", with: "capsule_616x353")
        let imageUrl = URL(string: betterSource)
        let imageData = imageUrl != nil ? try? Data(contentsOf: imageUrl!) : nil
        DispatchQueue.global(qos: .background).sync {
            let image = imageData != nil ? UIImage(data: imageData!)?.jpegData(compressionQuality: 90) : nil
            destination.thumb = image
        }
        return destination
    }
    override func mapTo(source: Deal, destination: inout DealNO) -> DealNO {
        destination.internalName = source.internalName
        destination.title = source.title
        destination.metacriticLink = source.metacriticLink
        destination.dealID = source.dealID
        destination.storeID = String(source.storeID)
        destination.gameID = source.gameID
        destination.salePrice = source.salePrice
        destination.normalPrice = source.normalPrice
        destination.isOnSale = source.isOnSale
        destination.savings = source.savings
        destination.metacriticScore = String(source.metacriticScore)
        destination.steamRatingText = source.steamRatingText
        destination.steamRatingPercent = String(source.steamRatingPercent ?? 0)
        destination.steamRatingCount = source.steamRatingCount
        destination.steamAppID = String(source.steamAppID ?? 0)
        destination.releaseDate = dateService.toEpoch(source.releaseDate)
        destination.lastChange = dateService.toEpoch(source.lastChange)
        destination.dealRating = source.dealRating
        destination.thumb = ""
        return destination
    }
    override func map(_ from: DealNO) -> Deal {
        var deal = Deal()
        return mapTo(source: from, destination: &deal)
    }
    override func map(_ from: Deal) -> DealNO {
        var dealNO = DealNO()
        return mapTo(source: from, destination: &dealNO)
    }
}
