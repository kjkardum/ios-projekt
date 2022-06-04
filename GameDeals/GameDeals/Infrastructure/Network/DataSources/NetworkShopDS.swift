//
//  NetworkShopDS.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 04.06.2022..
//

import Foundation

protocol NetworkShopDS {
    func getListOfShops(completionHandler: @escaping resultHandler<[ShopNO]>)
}
