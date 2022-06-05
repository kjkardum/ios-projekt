//
//  DbDealDSImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation
import CoreData

class DbDealDSImpl: DbDealDS {
    let context: NSManagedObjectContext
    let mapper: Mapper<DealMO, Deal>
    init(coreDataStack: CoreDataStack, mapper: Mapper<DealMO, Deal>) {
        self.context = coreDataStack.persistentContainer.viewContext
        self.mapper = mapper
    }
    
    func getListOfDeals(parameters: ListOfDealsParameters, completionHandler: @escaping resultHandler<[DealMO]>) {
        let request = DealMO.fetchRequest()
        var predicates: [NSPredicate] = []
        if let storeIds = parameters.storeIds {
            predicates.append(NSPredicate(format: "storeId IN %@", storeIds))
        }
        if parameters.lowerPrice != 0 {
            let lowerPrice = parameters.lowerPrice > 0 ? parameters.lowerPrice : 0
            predicates.append(NSPredicate(format: "salePrice >= %i", lowerPrice))
        }
        if parameters.upperPrice != 50 {
            let upperPrice = parameters.lowerPrice < 50 ? parameters.lowerPrice : 999
            predicates.append(NSPredicate(format: "salePrice <= %i", upperPrice))
        }
        if let metacritic = parameters.metacritic {
            predicates.append(NSPredicate(format: "metacriticScore >= %i", metacritic))
        }
        if let steamRating = parameters.steamRating {
            predicates.append(NSPredicate(format: "steamRatingPercent >= %i", steamRating))
        }
        if let steamAppIDs = parameters.steamAppID {
            if steamAppIDs.count > 0 {
                predicates.append(NSPredicate(format: "steamAppId IN %@", steamAppIDs))
            }
        }
        if let title = parameters.title {
            if !title.isEmpty {
                if parameters.exact {
                    predicates.append(NSPredicate(format: "title == %@", title))
                } else {
                    predicates.append(NSPredicate(format: "title LIKE %@", "*"+title+"*"))
                }
            }
        }
        if parameters.AAA {
            predicates.append(NSPredicate(format: "normalPrice > 29"))
        }
        if parameters.steamworks {
            // -\_('-')_/-
        }
        if parameters.onSale {
            predicates.append(NSPredicate(format: "normalPrice != salePrice"))
        }
        request.fetchOffset = parameters.pageNumber * parameters.pageSize
        request.fetchLimit = parameters.pageNumber
        let sortBy = parameters.sortBy
        request.sortDescriptors = [NSSortDescriptor(key: sortBy.asNSSortName(), ascending: !parameters.desc)]
        let deals = (try? context.fetch(request)) ?? []
        completionHandler(.success(deals))
    }
    
    func updateListOfDeals(parameters: ListOfDealsParameters, incomingDeals: [Deal], completionHandler: @escaping resultHandler<Bool>) {
        getListOfDeals(parameters: parameters, completionHandler: { result in
            switch(result){
            case .success(let existingDeals):
                let updatedDeals = existingDeals.filter { exDeal in incomingDeals.contains(where: { $0.dealID == exDeal.dealId}) }
                let deletedDeals = existingDeals.filter { exDeal in !incomingDeals.contains(where: { $0.dealID == exDeal.dealId}) }
                let addedDeals = incomingDeals.filter { inDeal in !existingDeals.contains(where: { inDeal.dealID == $0.dealId}) }
                var addedDealsMO: [DealMO] = []
                
                updatedDeals.forEach { deal in
                    var editable = deal
                    let incoming = incomingDeals.first(where: { $0.dealID == deal.dealId})!
                    editable = self.mapper.mapTo(source: incoming, destination: &editable)
                    
                }
                
                deletedDeals.forEach{ deal in
                    self.context.delete(deal)
                }
                
                addedDeals.forEach{ deal in
                    addedDealsMO.append(self.mapper.map(deal))
                }
                try? self.context.save()
                completionHandler(.success(true))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
    
    
}
