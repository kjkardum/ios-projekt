//
//  DbShopDSImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 04.06.2022..
//

import Foundation
import CoreData

class DbShopDSImpl: DbShopDS {
    let container: NSPersistentContainer
    init(coreDataStack: CoreDataStack) {
        self.container = coreDataStack.persistentContainer
    }
    
    func getListOfShops(completionHandler: @escaping resultHandler<[ShopMO]>) {
        fatalError("Not yet implemented")
    }
    
}
