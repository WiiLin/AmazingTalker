//
//  DateTests.swift
//  AmazingTalkerTests
//
//  Created by Wii Lin on 2021/7/10.
//

@testable import AmazingTalker
import XCTest

class DateTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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
        let dateString = "2021-07-10"
        let dateFormat = "YYYY-MM-dd"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        guard let date = dateFormatter.date(from: dateString) else {
            XCTAssert(false)
            return
        }
        XCTAssertTrue(date.year == 2021)
        XCTAssertTrue(date.month == 7)
        XCTAssertTrue(date.day == 10)
        XCTAssertTrue(date.weekday == 7)
    }
}
