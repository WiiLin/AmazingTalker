//
//  ExtensionTests.swift
//  AmazingTalkerTests
//
//  Created by Wii Lin on 2022/4/10.
//

@testable import AmazingTalker
import XCTest

class ExtensionTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    //MARK: - Test Color
    func testColorNotNil() throws {
        XCTAssertNotNil(UIColor.disableGray)
        XCTAssertNotNil(UIColor.enableGreen)
        XCTAssertNotNil(UIColor.textBlack)
    }
    
    //MARK: - Test Date
    func testWeekDateCount() {
        XCTAssertTrue(Date.weekDate(of: Date()).count == 7)
        XCTAssertTrue(Date.weekDayCount == 7)
    }

    func testDateCompare() {
        let date = Date()
        XCTAssertTrue(date.inSameDayAs(Date()))
        XCTAssertTrue(date.moreThanOrEqualTo(Date()))
        if let addDay = date.addDay(1) {
            XCTAssertTrue(addDay.moreThanOrEqualTo(Date()))
        } else {
            return XCTAssertTrue(false)
        }
    }

    func testDateComponent() {
        let dateString = "2022-04-10"
        let dateFormat = "YYYY-MM-dd"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        guard let date = dateFormatter.date(from: dateString) else {
            XCTAssert(false)
            return
        }
        XCTAssertTrue(date.year == 2022)
        XCTAssertTrue(date.month == 4)
        XCTAssertTrue(date.day == 10)
        XCTAssertTrue(date.weekday == 1)
    }
    
    
    //MARK: - Test URL
    func testURLNotNil() throws {
        XCTAssertNotNil(URL.apiHost)
        XCTAssertTrue(URL.apiURL(path: .timetable)?.absoluteString == "https://api.amazingtalker.com/timetable")

    }
    
}
