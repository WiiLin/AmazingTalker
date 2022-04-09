//
//  PeriodTests.swift
//  AmazingTalkerTests
//
//  Created by Wii Lin on 2022/4/10.
//

@testable import AmazingTalker
import XCTest

class PeriodTests: XCTestCase {
    private let apiRequestable: APIRequestable = FakeAPIHandler()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTimetableData() {
        let apiExpectation = expectation(description: "apiExpectation")
        apiRequestable.getTimetable { result in
            switch result {
            case let .success(timetable):
                let handler = PeriodHandler()
                handler.configure(timetable: timetable)
                XCTAssertTrue(handler.available.count > 0)
                XCTAssertTrue(handler.booked.count > 0)
            case let .failure(error):
                print(error.description)
                XCTAssertTrue(false)
            }
            apiExpectation.fulfill()
        }
        waitForExpectations(timeout: 20) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
