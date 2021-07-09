//
//  APIRequestHandlerTests.swift
//  AmazingTalkerTests
//
//  Created by Wii Lin on 2021/7/10.
//

@testable import AmazingTalker
import XCTest

class APIRequestHandlerTests: XCTestCase {
    lazy var requestHandler: APIRequestHandler = APIRequestHandler()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /* for real environment
     func testRequest() {
         let apiExpectation = expectation(description: "apiExpectation")
         let request = TimetableRequest()
         requestHandler.request(request, responseType: Timetable.self) { result in
             switch result {
             case .success:
                 XCTAssertTrue(true)
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
     */
}
