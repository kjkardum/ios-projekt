//
//  GamesRepositoryImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation

class GamesRepositoryImpl: GamesRepository {
    let networkDataSource: NetworkGameDS
    let networkGameMapper: Mapper<GameNO, Game>
    let networkDetailedGameMapper: Mapper<DetailedGameNO, DetailedGame>
    
    init(networkDS: NetworkGameDS,
         networkGameMapper: Mapper<GameNO, Game>,
         networkDetailedGameMapper: Mapper<DetailedGameNO, DetailedGame>) {
        self.networkDataSource = networkDS
        self.networkGameMapper = networkGameMapper
        self.networkDetailedGameMapper = networkDetailedGameMapper
    }
    func getListOfGames(title: String, exact: Bool, steamAppId: Int?, limit: Int?, completionHandler: @escaping resultHandler<[Game]>) {
        networkDataSource.getListOfGames(title: title, exact: exact, steamAppId: steamAppId, limit: limit, completionHandler: { result in
            switch (result) {
            case .success(let data):
                completionHandler(.success(data.map{ self.networkGameMapper.map($0) }))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
    
    func getGame(id: Int, completionHandler: @escaping resultHandler<DetailedGame>) {
        networkDataSource.getGame(id: id, completionHandler: { result in
            switch (result) {
            case .success(let data):
                completionHandler(.success(self.networkDetailedGameMapper.map(data)))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
    
}
