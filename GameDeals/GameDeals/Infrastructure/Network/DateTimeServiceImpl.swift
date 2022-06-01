//
//  DateTimeServiceImpl.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 01.06.2022..
//

import Foundation

class DateTimeServiceImpl: DateTimeService {
    let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd.MM.YYYY"
    }
    
    func parse(_ dateString: String) -> Date? {
        return dateFormatter.date(from: dateString)
    }
    
    func parse(_ epochDate: Int) -> Date {
        return Date(timeIntervalSince1970: Double(epochDate))
    }
    
    func stringify(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func toEpoch(_ date: Date) -> Int {
        return Int(date.timeIntervalSince1970)
    }
}
