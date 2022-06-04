//
//  GameSortingEnum.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

enum GameSortingEnum: String {
    case dealRating = "Deal Rating"
    case title = "Title"
    case savings = "Savings"
    case price = "Price"
    case metacritic = "Metacritic"
    case reviews = "Reviews"
    case release = "Release"
    case store = "Store"
    case recent = "recent"
}

extension GameSortingEnum {
    static func asList() -> [GameSortingEnum] {
        return [.dealRating, .title, .savings, .price, .metacritic, .reviews, .release, .store, .recent]
    }
    
    static func title(_ gameSortingEnum: GameSortingEnum) -> String {
        switch(gameSortingEnum) {
        case .dealRating:
            return "Deal Rating"
        case .title:
            return "Title"
        case .savings:
            return "Savings"
        case .price:
            return "Price"
        case .metacritic:
            return "Metacritic Rating"
        case .reviews:
            return "Reviews"
        case .release:
            return "Release Date"
        case .store:
            return "Store"
        case .recent:
            return "Recent"
        }
    }
}
