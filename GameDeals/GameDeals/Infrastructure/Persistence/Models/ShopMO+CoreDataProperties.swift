//
//  ShopMO+CoreDataProperties.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 05.06.2022..
//
//

import Foundation
import CoreData


extension ShopMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShopMO> {
        return NSFetchRequest<ShopMO>(entityName: "ShopMO")
    }

    @NSManaged public var banner: Data?
    @NSManaged public var image: Data?
    @NSManaged public var isActive: Int64
    @NSManaged public var logo: Data?
    @NSManaged public var storeId: Int64
    @NSManaged public var storeName: String?

}

extension ShopMO : Identifiable {

}
