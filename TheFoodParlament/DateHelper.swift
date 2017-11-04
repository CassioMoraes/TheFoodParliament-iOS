//
//  DateHelper.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 26/03/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import Foundation

class DateHelper {
    
    static func getDateAsString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        
        return dateFormatter.string(from: date as Date)
    }
    
    static func getDateFromString(time: String) -> Date? {
        let baseDate = Date()
        
        var calendar = NSCalendar.current
        calendar.timeZone = TimeZone(abbreviation: "GMT")!
        
        let day = calendar.component(.day, from: baseDate)
        let month = calendar.component(.month, from: baseDate)
        let year = calendar.component(.year, from: baseDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        
        let date = dateFormatter.date(from: "\(year)-\(month)-\(day) \(time)")
        
        return date
    }
    
    static func getDateFromString(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        
        let date = dateFormatter.date(from: date)
        
        return date
    }
    
    static func isDateBetween(date: Date, start: Date, end: Date) -> Bool {
         return (date >= start) && (date < end)
    }
    
    static func getFirstDayOfWeek(date: Date) -> Date? {
        var calendar = NSCalendar.current
        calendar.timeZone = TimeZone(abbreviation: "GMT")!

        let date = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))
        
        return date
    }
    
    static func getLastDayOfWeek(date: Date) -> Date? {
        var calendar = NSCalendar.current
        calendar.timeZone = TimeZone(abbreviation: "GMT")!
        
        let date = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: date!)
        
        return endOfWeek
    }
}
