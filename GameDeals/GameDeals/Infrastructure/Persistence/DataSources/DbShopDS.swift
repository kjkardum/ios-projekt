//
//  DbShopDS.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 04.06.2022..
//

import Foundation

protocol DbShopDS {
    func getListOfShops(completionHandler: @escaping resultHandler<[ShopMO]>)
}
