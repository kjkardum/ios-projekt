//
//  DbShopDSImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 04.06.2022..
//

import Foundation
import CoreData

class DbShopDSImpl: DbShopDS {
    let context: NSManagedObjectContext
    let mapper: Mapper<ShopMO, Shop>
    init(coreDataStack: CoreDataStack, mapper: Mapper<ShopMO, Shop>) {
        self.context = coreDataStack.persistentContainer.viewContext
        self.mapper = mapper
    }
    
    func getListOfShops(completionHandler: @escaping resultHandler<[ShopMO]>) {
        let request = ShopMO.fetchRequest() as NSFetchRequest<ShopMO>
        let shops = try? context.fetch(request)
        completionHandler(.success(shops ?? []))
    }
    
    func updateListOfShops(incomingShops: [Shop], completionHandler: @escaping resultHandler<Bool>) {
        let existingShops = (try? context.fetch(ShopMO.fetchRequest())) ?? []
        
        let updatedShops = existingShops.filter { exShop in incomingShops.contains(where: { $0.storeID == exShop.storeId}) }
        let deletedShops = existingShops.filter { exShop in !incomingShops.contains(where: { $0.storeID == exShop.storeId}) }
        let addedShops = incomingShops.filter { inShop in !existingShops.contains(where: { inShop.storeID == $0.storeId}) }
        var addedShopsMO: [ShopMO] = []
        
        updatedShops.forEach{ shop in
            let incomingShop = incomingShops.first(where: { $0.storeID == shop.storeId})!
            shop.storeName = incomingShop.storeName
            shop.isActive = Int64(incomingShop.isActive)
        }
        
        deletedShops.forEach{ shop in
            context.delete(shop)
        }
        
        addedShops.forEach{ shop in
            addedShopsMO.append(mapper.map(shop))
        }
        try? context.save()
        completionHandler(.success(true))
    }
    
}
