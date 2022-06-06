//
//  DealsRepository.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 31.05.2022..
//

import Foundation

protocol DealsRepository {
    func getListOfDeals(parameters: ListOfDealsParameters, completionHandler: @escaping resultHandler<[Deal]>)
    func getDeal(id: String, completionHandler: @escaping resultHandler<DetailedDeal>)
    func likeDeal(dealId: String, like: Bool, completionHandler: @escaping resultHandler<Bool>)
    func getLikedDeals(completionHandler: @escaping resultHandler<[Deal]>)
}
