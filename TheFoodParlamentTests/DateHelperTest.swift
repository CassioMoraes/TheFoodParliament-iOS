//
//  DateHelperTest.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 26/03/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import XCTest
@testable import TheFoodParlament

class DateHelperTest: XCTestCase {
       
    func testGetDateAsString() {
        let expected = "2017-01-01"
        
        let dateString = "01-01-2017"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        
        let dateTest = dateFormatter.date(from: dateString)
        
        let result = DateHelper.getDateAsString(date: dateTest!)
        
        XCTAssertEqual(expected, result)
    }
    
    func testGetDateFromString_PassingOnlyTime() {
        let resultDate = DateHelper.getDateFromString(time: "23:59:59")
        
        var calendar = NSCalendar.current
        calendar.timeZone = TimeZone(abbreviation: "GMT")!
        let expectedDate = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: Date())
        
        XCTAssertEqual(expectedDate, resultDate)
    }
    
    func testGetDateFromString_PassingOnlyDate() {
        let resultDate = DateHelper.getDateFromString(date: "2017-01-01")
        
        var calendar = NSCalendar.current
        calendar.timeZone = TimeZone(abbreviation: "GMT")!
        
        let dateString = "01-01-2017"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
       
        let expectedDate = dateFormatter.date(from: dateString)

        XCTAssertEqual(expectedDate, resultDate)
    }
    
    func testIsDateBetween_ReturnTrue() {
        var calendar = NSCalendar.current
        calendar.timeZone = TimeZone(abbreviation: "GMT")!

        let startDate = calendar.date(bySettingHour: 10, minute: 00, second: 00, of: Date())!
        let endDate = calendar.date(bySettingHour: 11, minute: 00, second: 00, of: Date())!
        let currentDate =  calendar.date(bySettingHour: 10, minute: 30, second: 00, of: Date())!

        let result = DateHelper.isDateBetween(date: currentDate, start: startDate, end: endDate)
        
        XCTAssertTrue(result)
    }
    
    func testIsDateBetween_DateBefore_ReturnFalse() {
        var calendar = NSCalendar.current
        calendar.timeZone = TimeZone(abbreviation: "GMT")!
        
        let startDate = calendar.date(bySettingHour: 10, minute: 00, second: 00, of: Date())!
        let endDate = calendar.date(bySettingHour: 11, minute: 00, second: 00, of: Date())!
        let currentDate =  calendar.date(bySettingHour: 09, minute: 30, second: 00, of: Date())!
        
        let result = DateHelper.isDateBetween(date: currentDate, start: startDate, end: endDate)
        
        XCTAssertFalse(result)
    }
    
    func testIsDateBetween_DateAfter_ReturnFalse() {
        var calendar = NSCalendar.current
        calendar.timeZone = TimeZone(abbreviation: "GMT")!
        
        let startDate = calendar.date(bySettingHour: 10, minute: 00, second: 00, of: Date())!
        let endDate = calendar.date(bySettingHour: 11, minute: 00, second: 00, of: Date())!
        let currentDate =  calendar.date(bySettingHour: 11, minute: 01, second: 00, of: Date())!
        
        let result = DateHelper.isDateBetween(date: currentDate, start: startDate, end: endDate)
        
        XCTAssertFalse(result)
    }
    
    func testGetFirstDayOfWeek() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        
        let baseDate = dateFormatter.date(from: "2017-03-29")
        let expectedDate = dateFormatter.date(from: "2017-03-26")
        let result = DateHelper.getFirstDayOfWeek(date: baseDate!)
        
        XCTAssertEqual(expectedDate, result)
    }
    
    func testGetLastDayOfWeek() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        
        let baseDate = dateFormatter.date(from: "2017-03-29")
        let expectedDate = dateFormatter.date(from: "2017-04-01")
        let result = DateHelper.getLastDayOfWeek(date: baseDate!)
        
        XCTAssertEqual(expectedDate, result)
    }
}
