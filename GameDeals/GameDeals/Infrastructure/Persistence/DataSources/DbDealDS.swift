//
//  DbDealDS.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation

protocol DbDealDS {
    func getListOfDeals(parameters: ListOfDealsParameters, completionHandler: @escaping resultHandler<[DealMO]>)
    func updateListOfDeals(parameters: ListOfDealsParameters, incomingDeals: [Deal], completionHandler: @escaping resultHandler<Bool>)
}
