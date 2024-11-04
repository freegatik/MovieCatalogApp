//
//  AppErrorTests.swift
//  MovariumTests
//
//  Created by Anton Solovev on 04.11.2024.
//

import XCTest
@testable import Movarium

final class AppErrorTests: XCTestCase {
    func testMapUnauthorized() {
        struct Plain: Error {}
        let mapped = AppError.map(Plain(), httpStatus: 401)
        XCTAssertEqual(mapped, .unauthorized)
    }

    func testMapClient() {
        let err = NSError(domain: "x", code: 1, userInfo: nil)
        XCTAssertEqual(AppError.map(err, httpStatus: 404), .client(code: 404))
    }

    func testMapServer() {
        let err = NSError(domain: "x", code: 1, userInfo: nil)
        XCTAssertEqual(AppError.map(err, httpStatus: 500), .server(code: 500))
    }

    func testMapURLError() {
        let err = URLError(.notConnectedToInternet)
        let mapped = AppError.map(err, httpStatus: nil)
        guard case .transport(let code) = mapped else {
            XCTFail("Expected transport")
            return
        }
        XCTAssertEqual(code, .notConnectedToInternet)
    }

    func testLocalizedDescriptionUnauthorized() {
        XCTAssertFalse(AppError.unauthorized.errorDescription?.isEmpty ?? true)
    }
}
