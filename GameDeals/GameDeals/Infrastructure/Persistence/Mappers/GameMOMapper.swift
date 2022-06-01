//
//  GameMOMapper.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation

class GameMOMapper: Mapper<GameMO, Game> {
    override func mapTo(source: GameMO, destination: inout Game) -> Game {
        destination.gameID = source.gameId ?? ""
        destination.steamAppID = source.steamAppId ?? ""
        destination.cheapest = source.cheapest ?? ""
        destination.cheapestDealID = source.cheapestDealId ?? ""
        destination.external = source.external ?? ""
        destination.thumb = source.thumb
        return destination
    }
    
    override func mapTo(source: Game, destination: inout GameMO) -> GameMO {
        destination.gameId = source.gameID
        destination.steamAppId = source.steamAppID
        destination.cheapest = source.cheapest
        destination.cheapestDealId = source.cheapestDealID
        destination.external = source.external
        destination.thumb = source.thumb
        return destination
    }
    
    override func map(_ from: GameMO) -> Game {
        var game = Game()
        return mapTo(source: from, destination: &game)
    }
    
    override func map(_ from: Game) -> GameMO {
        var gameMO = GameMO()
        return mapTo(source: from, destination: &gameMO)
    }
}
