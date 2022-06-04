//
//  ShopMOMapper.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 04.06.2022..
//

import Foundation
import CoreData

class ShopMOMapper: Mapper<ShopMO, Shop> {
    let context: NSManagedObjectContext
    init(coreDataStack: CoreDataStack) {
        self.context = coreDataStack.persistentContainer.viewContext
    }
    
    override func mapTo(source: ShopMO, destination: inout Shop) -> Shop {
        destination.storeID = source.storeId ?? ""
        destination.storeName = source.storeName ?? ""
        destination.isActive = Int(truncatingIfNeeded: source.isActive)
        destination.images = ShopImage(banner: source.banner, logo: source.logo, icon: source.image)
        return destination
    }
    
    override func mapTo(source: Shop, destination: inout ShopMO) -> ShopMO {
        destination.storeId = source.storeID
        destination.storeName = source.storeName
        destination.isActive = Int64(source.isActive)
        destination.banner = source.images.banner
        destination.logo = source.images.logo
        destination.image = source.images.icon
        return destination
    }
    
    override func map(_ from: ShopMO) -> Shop {
        var shop = Shop()
        return mapTo(source: from, destination: &shop)
    }
    
    override func map(_ from: Shop) -> ShopMO {
        var shopMO = ShopMO(context: context)
        return mapTo(source: from, destination: &shopMO)
    }
}
