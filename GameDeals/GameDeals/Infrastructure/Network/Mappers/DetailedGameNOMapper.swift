//
//  DetailedGameNOMapper.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import UIKit

class DetailedGameNOMapper: Mapper<DetailedGameNO, DetailedGame> {
    let dateService: DateTimeService
    init(dateService: DateTimeService) {
        self.dateService = dateService
    }
    
    override func mapTo(source: DetailedGameNO, destination: inout DetailedGame) -> DetailedGame {
        let betterSource = source.info.thumb.replacingOccurrences(of: "capsule_sm_120", with: "capsule_616x353")
        let imageUrl = URL(string: betterSource)
        let imageData = imageUrl != nil ? try? Data(contentsOf: imageUrl!) : nil
        var thumb: Data? = nil
        DispatchQueue.global(qos: .background).sync {
            let image = imageData != nil ? UIImage(data: imageData!)?.jpegData(compressionQuality: 90) : nil
            thumb = image
        }
        
        destination.cheapestPriceEver = DealCheapestPrice(price: source.cheapestPriceEver.price,
                                                          date: source.cheapestPriceEver.date != nil ? dateService.parse(source.cheapestPriceEver.date!) : nil)
        destination.info = GameInfo(title: source.info.title, steamAppID: source.info.steamAppID, thumb: thumb)
        destination.deals = source.deals.map { GameDeal(storeID: $0.storeID,
                                                        dealID: $0.dealID,
                                                        price: $0.price,
                                                        retailPrice: $0.retailPrice,
                                                        savings: $0.savings) }
        return destination
    }
    override func mapTo(source: DetailedGame, destination: inout DetailedGameNO) -> DetailedGameNO {
        destination.cheapestPriceEver = DealCheapestPriceNO(price: source.cheapestPriceEver.price,
                                                            date: source.cheapestPriceEver.date != nil ? dateService.toEpoch(source.cheapestPriceEver.date!) : nil)
        destination.info = GameInfoNO(title: source.info.title, steamAppID: source.info.steamAppID, thumb: "")
        destination.deals = source.deals.map { GameDealNO(storeID: $0.storeID,
                                                        dealID: $0.dealID,
                                                        price: $0.price,
                                                        retailPrice: $0.retailPrice,
                                                        savings: $0.savings) }
        return destination
    }
    override func map(_ from: DetailedGameNO) -> DetailedGame {
        var game = DetailedGame()
        return mapTo(source: from, destination: &game)
    }
    override func map(_ from: DetailedGame) -> DetailedGameNO {
        var gameNO = DetailedGameNO()
        return mapTo(source: from, destination: &gameNO)
    }
}
