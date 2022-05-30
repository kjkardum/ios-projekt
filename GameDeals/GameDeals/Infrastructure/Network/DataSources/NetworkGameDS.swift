//
//  NetworkGameDS.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

protocol NetworkGameDS {
    func getListOfGames(title: String, exact: Bool, steamAppId: Int?, limit: Int?) -> [GameNO]
    func getGame(id: Int) -> DetailedGameNO
}
