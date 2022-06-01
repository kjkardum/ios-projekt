//
//  GameMO+CoreDataProperties.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//
//

import Foundation
import CoreData


extension GameMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameMO> {
        return NSFetchRequest<GameMO>(entityName: "GameMO")
    }

    @NSManaged public var gameId: String?
    @NSManaged public var steamAppId: String?
    @NSManaged public var cheapest: String?
    @NSManaged public var cheapestDealId: String?
    @NSManaged public var external: String?
    @NSManaged public var thumb: Data?

}

extension GameMO : Identifiable {

}
