//
//  DealMO+CoreDataProperties.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 05.06.2022..
//
//

import Foundation
import CoreData


extension DealMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DealMO> {
        return NSFetchRequest<DealMO>(entityName: "DealMO")
    }

    @NSManaged public var dealId: String?
    @NSManaged public var dealRating: Double
    @NSManaged public var gameId: String?
    @NSManaged public var internalName: String?
    @NSManaged public var isOnSale: String?
    @NSManaged public var lastChange: Int64
    @NSManaged public var metacriticLink: String?
    @NSManaged public var metacriticScore: Int64
    @NSManaged public var normalPrice: NSDecimalNumber?
    @NSManaged public var releaseDate: Int64
    @NSManaged public var salePrice: NSDecimalNumber?
    @NSManaged public var savings: String?
    @NSManaged public var steamAppId: Int64
    @NSManaged public var steamRatingCount: String?
    @NSManaged public var steamRatingPercent: Int64
    @NSManaged public var steamRatingText: String?
    @NSManaged public var storeId: Int64
    @NSManaged public var thumb: Data?
    @NSManaged public var title: String?

}

extension DealMO : Identifiable {

}
