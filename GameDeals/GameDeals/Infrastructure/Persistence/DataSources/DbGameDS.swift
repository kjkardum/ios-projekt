//
//  DbGameDS.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation

protocol DbGameDS {
    func getListOfGames(title: String, exact: Bool, steamAppId: Int?, limit: Int?, completionHandler: @escaping resultHandler<[GameMO]>)
    func updateListOfGames(title: String, exact: Bool, steamAppId: Int?, limit: Int?, completionHandler: @escaping resultHandler<Bool>)
}
