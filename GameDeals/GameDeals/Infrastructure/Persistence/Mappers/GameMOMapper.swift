//
//  GameMOMapper.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation

class GameMOMapper: Mapper<GameMO, Game> {
    override func mapTo(source: GameMO, destination: inout Game) -> Game {
        fatalError("Not yet implemented")
    }
    
    override func mapTo(source: Game, destination: inout GameMO) -> GameMO {
        fatalError("Not yet implemented")
    }
    
    override func map(_: GameMO) -> Game {
        fatalError("Not yet implemented")
    }
    
    override func map(_: Game) -> GameMO {
        fatalError("Not yet implemented")
    }
}
