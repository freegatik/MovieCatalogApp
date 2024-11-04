//
//  LogoutUseCaseTests.swift
//  MovariumTests
//
//  Created by Anton Solovev on 04.11.2024.
//

import XCTest
@testable import Movarium

private final class MockLogoutRepository: LogoutRepository {
    var logoutResult: Result<UserAuthResponseModel, Error> = .success(UserAuthResponseModel(token: ""))
    var removeTokenError: Error?
    private(set) var logoutCallCount = 0
    private(set) var removeTokenCallCount = 0

    func logout() async throws -> UserAuthResponseModel {
        logoutCallCount += 1
        switch logoutResult {
        case .success(let m): return m
        case .failure(let e): throw e
        }
    }

    func removeToken() throws {
        removeTokenCallCount += 1
        if let removeTokenError { throw removeTokenError }
    }
}

final class LogoutUseCaseTests: XCTestCase {
    func testExecuteCallsLogoutAndRemovesToken() async throws {
        let repo = MockLogoutRepository()
        let sut = LogoutUseCaseImpl(repository: repo)

        try await sut.execute()

        XCTAssertEqual(repo.logoutCallCount, 1)
        XCTAssertEqual(repo.removeTokenCallCount, 1)
    }

    func testExecutePropagatesLogoutError() async throws {
        let repo = MockLogoutRepository()
        struct E: Error {}
        repo.logoutResult = .failure(E())
        let sut = LogoutUseCaseImpl(repository: repo)

        do {
            try await sut.execute()
            XCTFail("expected error")
        } catch {
            XCTAssertEqual(repo.removeTokenCallCount, 0)
        }
    }
}
