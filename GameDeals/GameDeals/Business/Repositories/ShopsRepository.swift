//
//  ShopsRepository.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 04.06.2022..
//

import Foundation

protocol ShopsRepository {
    func getListOfShops(completionHandler: @escaping resultHandler<[Shop]>)
}
