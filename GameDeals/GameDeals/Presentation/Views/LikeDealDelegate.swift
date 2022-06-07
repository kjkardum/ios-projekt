//
//  LikeDealDelegate.swift
//  GameDeals
//
//  Created by Five on 07.06.2022..
//

import Foundation


protocol LikeDealDelegate: AnyObject {
    func likeDeal(dealId: String, like: Bool)
}
