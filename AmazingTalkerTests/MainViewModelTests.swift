//
//  MainViewModelTests.swift
//  AmazingTalkerTests
//
//  Created by Wii Lin on 2022/4/10.
//

@testable import AmazingTalker
import XCTest

class MainViewModelTests: XCTestCase {
    private let viewModel: MainViewModel = .init(apiRequestable: FakeAPIHandler(), beginDate: Date())
    var expectation: XCTestExpectation? // 2
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsLoading() {
        expectation = expectation(description: "apiExpectation")
        let viewModel = MainViewModel(apiRequestable: FakeAPIHandler(), beginDate: Date())
        viewModel.delegate = self
        XCTAssertFalse(viewModel.isLoading)
        viewModel.getCalander()
        waitForExpectations(timeout: 1)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testWeekMove() {
        let viewModel = MainViewModel(apiRequestable: FakeAPIHandler(), beginDate: Date())
        XCTAssertFalse(viewModel.canGoLastWeek)
        XCTAssertTrue(viewModel.canGoNextWeek)
    }
}

extension MainViewModelTests: MainViewModelDelegate {
    func didChangeWeek() {}

    func didFinishedLoadTimetable() {
        expectation?.fulfill()
        expectation = nil
    }
}
