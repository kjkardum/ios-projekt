//
//  DateTimeService.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation

protocol DateTimeService {
    func parse(_ dateString: String) -> Date?
    func parse(_ epochDate: Int) -> Date
    func stringify(_ date: Date) -> String
    func toEpoch(_ date: Date) -> Int
}
