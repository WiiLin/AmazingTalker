//
//  APIPathTests.swift
//  AmazingTalkerTests
//
//  Created by Wii Lin on 2021/7/10.
//

@testable import AmazingTalker
import XCTest

class APIPathTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPITestData() {
        XCTAssertNotNil(APIPath.timetable.testData)
    }
}
