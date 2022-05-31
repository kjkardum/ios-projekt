//
//  DealNOMapper.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 31.05.2022..
//

import UIKit

class DealNOMapper: Mapper<DealNO, Deal> {
    override func mapTo(source: DealNO, destination: inout Deal) -> Deal {
        destination.internalName = source.internalName
        destination.title = source.title
        destination.metacriticLink = source.metacriticLink
        destination.dealID = source.dealID
        destination.storeID = source.storeID
        destination.gameID = source.gameID
        destination.salePrice = source.salePrice
        destination.normalPrice = source.normalPrice
        destination.isOnSale = source.isOnSale
        destination.savings = source.savings
        destination.metacriticScore = source.metacriticScore
        destination.steamRatingText = source.steamRatingText
        destination.steamRatingPercent = source.steamRatingPercent
        destination.steamRatingCount = source.steamRatingCount
        destination.steamAppID = source.steamAppID
        destination.releaseDate = source.releaseDate
        destination.lastChange = source.lastChange
        destination.dealRating = source.dealRating
        
        let imageUrl = URL(string: source.thumb)
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
        destination.storeID = source.storeID
        destination.gameID = source.gameID
        destination.salePrice = source.salePrice
        destination.normalPrice = source.normalPrice
        destination.isOnSale = source.isOnSale
        destination.savings = source.savings
        destination.metacriticScore = source.metacriticScore
        destination.steamRatingText = source.steamRatingText
        destination.steamRatingPercent = source.steamRatingPercent
        destination.steamRatingCount = source.steamRatingCount
        destination.steamAppID = source.steamAppID
        destination.releaseDate = source.releaseDate
        destination.lastChange = source.lastChange
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
