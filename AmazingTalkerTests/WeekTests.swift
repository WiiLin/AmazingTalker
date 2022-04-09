//
//  WeekTests.swift
//  AmazingTalkerTests
//
//  Created by Wii Lin on 2022/4/10.
//

@testable import AmazingTalker
import XCTest

class WeekTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWeek() {
        let week = Week(date: Date())
        XCTAssertTrue(week.dates.count == 7)
        XCTAssertNotNil(week.first)
        XCTAssertNotNil(week.last)
    }

    func testGoLastWeek() {
        let week = Week(date: Date())
        let first = week.first
        let last = week.last
        week.goLastWeek()
        XCTAssertTrue(first?.addDay(-7)?.inSameDayAs(week.first) ?? false)
        XCTAssertTrue(last?.addDay(-7)?.inSameDayAs(week.last) ?? false)
    }

    func testGoNextWeek() {
        let week = Week(date: Date())
        let first = week.first
        let last = week.last
        week.goNextWeek()
        XCTAssertTrue(first?.addDay(7)?.inSameDayAs(week.first) ?? false)
        XCTAssertTrue(last?.addDay(7)?.inSameDayAs(week.last) ?? false)
    }
}
