//
//  PriceRangeEnum.swift
//  GameDeals
//
//  Created by Five on 04.06.2022..
//

import Foundation


enum PriceRangeEnum: Int {
    case under5 = 5
    case under10 = 10
    case under20 = 20
    case under30 = 30
    case under40 = 40
    case noFilter = 50
}

extension PriceRangeEnum {
    static func title(_ priceRangeEnum: PriceRangeEnum) -> String {
        switch priceRangeEnum {
        case .under5:
            return "Under 5$"
        case .under10:
            return "Under 10$"
        case .under20:
            return "Under 20$"
        case .under30:
            return "Under 30$"
        case .under40:
            return "Under 40$"
        case .noFilter:
            return "Any Price"
        }
    }
    
    static func asList() -> [PriceRangeEnum] {
        return [.noFilter, .under5, .under10, .under20, .under30, .under40]
    }
}
