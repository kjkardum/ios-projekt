//
//  NetworkDealDS.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

protocol NetworkDealDS {
    func getListOfDeals(parameters: ListOfDealsParameters) -> [DealNO]
    func getDeal(int: String) -> DetailedDealNO
}
