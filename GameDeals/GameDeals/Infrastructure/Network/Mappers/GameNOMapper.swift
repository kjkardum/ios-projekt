//
//  GameNOMapper.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import UIKit

class GameNOMapper: Mapper<GameNO, Game> {
    override func mapTo(source: GameNO, destination: inout Game) -> Game {
        let betterSource = source.thumb.replacingOccurrences(of: "capsule_sm_120", with: "capsule_616x353")
        let imageUrl = URL(string: betterSource)
        let imageData = imageUrl != nil ? try? Data(contentsOf: imageUrl!) : nil
        var thumb: Data? = nil
        DispatchQueue.global(qos: .background).sync {
            let image = imageData != nil ? UIImage(data: imageData!)?.jpegData(compressionQuality: 90) : nil
            thumb = image
        }
        
        destination.gameID = source.gameID
        destination.steamAppID = source.steamAppID
        destination.cheapest = source.cheapest
        destination.cheapestDealID = source.cheapestDealID
        destination.external = source.external
        destination.thumb = thumb
        return destination
    }
    
    override func mapTo(source: Game, destination: inout GameNO) -> GameNO {
        destination.gameID = source.gameID
        destination.steamAppID = source.steamAppID
        destination.cheapest = source.cheapest
        destination.cheapestDealID = source.cheapestDealID
        destination.external = source.external
        destination.thumb = ""
        return destination
    }
    
    override func map(_ from: GameNO) -> Game {
        var game = Game()
        return mapTo(source: from, destination: &game)
    }
    
    override func map(_ from: Game) -> GameNO {
        var gameNO = GameNO()
        return mapTo(source: from, destination: &gameNO)
    }
}
