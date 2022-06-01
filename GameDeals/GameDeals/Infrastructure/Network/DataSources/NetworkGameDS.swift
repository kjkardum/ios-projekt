//
//  NetworkGameDS.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

protocol NetworkGameDS {
    func getListOfGames(title: String, exact: Bool, steamAppId: Int?, limit: Int?, completionHandler: @escaping resultHandler<[GameNO]>)
    func getGame(id: Int, completionHandler: @escaping resultHandler<DetailedGameNO>)
}
