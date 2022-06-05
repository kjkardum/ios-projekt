//
//  DetailedDealNOMapper.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import UIKit

class DetailedDealNOMapper: Mapper<DetailedDealNO, DetailedDeal> {
    let dateService: DateTimeService
    init(dateService: DateTimeService) {
        self.dateService = dateService
    }
    
    override func mapTo(source: DetailedDealNO, destination: inout DetailedDeal) -> DetailedDeal {
        let betterSource = source.gameInfo.thumb.replacingOccurrences(of: "capsule_sm_120", with: "capsule_616x353")
        let imageUrl = URL(string: betterSource)
        let imageData = imageUrl != nil ? try? Data(contentsOf: imageUrl!) : nil
        var thumb: Data? = nil
        DispatchQueue.global(qos: .background).sync {
            let image = imageData != nil ? UIImage(data: imageData!)?.jpegData(compressionQuality: 90) : nil
            thumb = image
        }
        destination.gameInfo = DealGame(storeID: source.gameInfo.storeID,
                                        gameID: source.gameInfo.gameID,
                                        name: source.gameInfo.name,
                                        steamAppID: source.gameInfo.steamAppID,
                                        salePrice: source.gameInfo.salePrice,
                                        retailPrice: source.gameInfo.retailPrice,
                                        steamRatingText: source.gameInfo.steamRatingText,
                                        steamRatingPercent: source.gameInfo.steamRatingPercent,
                                        steamRatingCount: source.gameInfo.steamRatingCount,
                                        metacriticScore: source.gameInfo.metacriticScore,
                                        metacriticLink: source.gameInfo.metacriticLink,
                                        releaseDate: dateService.parse(source.gameInfo.releaseDate),
                                        publisher: source.gameInfo.publisher,
                                        steamworks: source.gameInfo.steamworks,
                                        thumb: thumb)
        destination.cheaperStores = source.cheaperStores.map { DealCheaperStore(dealID: $0.dealID,
                                                                                storeID: $0.storeID,
                                                                                salePrice: $0.salePrice,
                                                                                retailPrice: $0.retailPrice)}
        destination.cheapestPrice = DealCheapestPrice(price: source.cheapestPrice.price,
                                                      date: source.cheapestPrice.date != nil ? dateService.parse(source.cheapestPrice.date!) : nil)
        return destination
    }
    
    override func mapTo(source: DetailedDeal, destination: inout DetailedDealNO) -> DetailedDealNO {
        destination.gameInfo = DealGameNO(storeID: source.gameInfo.storeID,
                                          gameID: source.gameInfo.gameID,
                                          name: source.gameInfo.name,
                                          steamAppID: source.gameInfo.steamAppID,
                                          salePrice: source.gameInfo.salePrice,
                                          retailPrice: source.gameInfo.retailPrice,
                                          steamRatingText: source.gameInfo.steamRatingText,
                                          steamRatingPercent: source.gameInfo.steamRatingPercent,
                                          steamRatingCount: source.gameInfo.steamRatingCount,
                                          metacriticScore: source.gameInfo.metacriticScore,
                                          metacriticLink: source.gameInfo.metacriticLink,
                                          releaseDate: dateService.toEpoch(source.gameInfo.releaseDate),
                                          publisher: source.gameInfo.publisher,
                                          steamworks: source.gameInfo.steamworks,
                                          thumb: "")
        destination.cheaperStores = source.cheaperStores.map { DealCheaperStoreNO(dealID: $0.dealID,
                                                                                  storeID: $0.storeID,
                                                                                  salePrice: $0.salePrice,
                                                                                  retailPrice: $0.retailPrice) }
        destination.cheapestPrice = DealCheapestPriceNO(price: source.cheapestPrice.price,
                                                        date: source.cheapestPrice.date != nil ? dateService.toEpoch(source.cheapestPrice.date!) : nil)
        return destination
    }
    
    override func map(_ from: DetailedDealNO) -> DetailedDeal {
        var deal = DetailedDeal()
        return mapTo(source: from, destination: &deal)
    }
    
    override func map(_ from: DetailedDeal) -> DetailedDealNO {
        var dealNO = DetailedDealNO()
        return mapTo(source: from, destination: &dealNO)
    }
}
