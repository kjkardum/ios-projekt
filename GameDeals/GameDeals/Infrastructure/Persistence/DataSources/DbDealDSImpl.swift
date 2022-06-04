//
//  DbDealDSImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation
import CoreData

class DbDealDSImpl: DbDealDS {
    let container: NSPersistentContainer
    init(coreDataStack: CoreDataStack) {
        self.container = coreDataStack.persistentContainer
    }
    
    func getListOfDeals(parameters: ListOfDealsParameters, completionHandler: @escaping resultHandler<[DealMO]>) {
        fatalError("Not yet implemented")
    }
    
    func updateListOfDeals(parameters: ListOfDealsParameters, completionHandler: @escaping resultHandler<Bool>) {
        fatalError("Not yet implemented")
    }
    
    
}
