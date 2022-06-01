//
//  GamesRepository.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation

protocol GamesRepository {
    func getListOfGames(title: String, exact: Bool, steamAppId: Int?, limit: Int?, completionHandler: @escaping resultHandler<[Game]>)
    func getGame(id: Int, completionHandler: @escaping resultHandler<DetailedGame>) 
}
