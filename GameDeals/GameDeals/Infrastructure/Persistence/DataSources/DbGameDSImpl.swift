//
//  DbGameDSImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation
import CoreData

class DbGameDSImpl: DbGameDS {
    let container: NSPersistentContainer
    init(coreDataStack: CoreDataStack) {
        self.container = coreDataStack.persistentContainer
    }
    
    func getListOfGames(title: String, exact: Bool, steamAppId: Int?, limit: Int?, completionHandler: @escaping resultHandler<[GameMO]>) {
        fatalError("Not yet implemented")
    }
    
    func updateListOfGames(title: String, exact: Bool, steamAppId: Int?, limit: Int?, completionHandler: @escaping resultHandler<Bool>) {
        fatalError("Not yet implemented")
    }
    
}
