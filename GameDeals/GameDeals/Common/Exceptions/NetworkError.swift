//
//  NetworkError.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

enum NetworkError: Error {
    case conversionError(String)
    case httpError(String)
    case jsonError(String)
    case clientError
}
