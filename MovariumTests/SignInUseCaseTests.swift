//
//  SignInUseCaseTests.swift
//  MovariumTests
//
//  Created by Anton Solovev on 04.11.2024.
//

import XCTest
@testable import Movarium

private final class MockSignInRepository: SignInRepository {
    var authorizeResult: Result<UserAuthResponseModel, Error> = .success(UserAuthResponseModel(token: "t"))
    var saveTokenError: Error?
    private(set) var authorizeCalls: [LoginCredentialsRequestModel] = []
    private(set) var savedTokens: [String] = []

    func authorizeUser(request: LoginCredentialsRequestModel) async throws -> UserAuthResponseModel {
        authorizeCalls.append(request)
        switch authorizeResult {
        case .success(let model): return model
        case .failure(let err): throw err
        }
    }

    func saveToken(token: String) throws {
        if let saveTokenError { throw saveTokenError }
        savedTokens.append(token)
    }
}

final class SignInUseCaseTests: XCTestCase {
    func testExecuteSavesTokenOnSuccess() async throws {
        let repo = MockSignInRepository()
        repo.authorizeResult = .success(UserAuthResponseModel(token: "abc123"))
        let sut = SignInUseCaseImpl(repository: repo)
        let request = LoginCredentialsRequestModel(username: "u", password: "p")

        try await sut.execute(request: request)

        XCTAssertEqual(repo.savedTokens, ["abc123"])
        XCTAssertEqual(repo.authorizeCalls.count, 1)
        XCTAssertEqual(repo.authorizeCalls.first?.username, "u")
    }

    func testExecutePropagatesAuthorizeError() async throws {
        let repo = MockSignInRepository()
        struct E: Error {}
        repo.authorizeResult = .failure(E())
        let sut = SignInUseCaseImpl(repository: repo)

        do {
            try await sut.execute(request: LoginCredentialsRequestModel(username: "a", password: "b"))
            XCTFail("expected error")
        } catch {
            XCTAssertTrue(repo.savedTokens.isEmpty)
        }
    }

    func testExecutePropagatesSaveTokenError() async throws {
        let repo = MockSignInRepository()
        struct E: Error {}
        repo.saveTokenError = E()
        let sut = SignInUseCaseImpl(repository: repo)

        do {
            try await sut.execute(request: LoginCredentialsRequestModel(username: "a", password: "b"))
            XCTFail("expected error")
        } catch {}
    }
}
