//
//  FilterDelegate.swift
//  GameDeals
//
//  Created by Five on 04.06.2022..
//

import Foundation


protocol FilterDelegate: AnyObject {
    func acceptFilters(_ listOfDealsParameters: ListOfDealsParameters)
}
