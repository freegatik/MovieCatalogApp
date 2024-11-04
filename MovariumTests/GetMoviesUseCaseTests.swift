//
//  GetMoviesUseCaseTests.swift
//  MovariumTests
//
//  Created by Anton Solovev on 04.11.2024.
//

import XCTest
@testable import Movarium

private final class MockGetMoviesRepository: GetMoviesRepository {
    var pages: [Int: MoviesPagedListResponseModel] = [:]
    private(set) var requestedPages: [Int] = []

    func getMovies(page: Int) async throws -> MoviesPagedListResponseModel {
        requestedPages.append(page)
        if let model = pages[page] { return model }
        return MoviesPagedListResponseModel(movies: [], pageInfo: PageInfoModel(pageSize: 0, pageCount: 0, currentPage: page))
    }

    func getMovieDetails(movieID: String) async throws -> MovieDetailsModel {
        MovieDetailsModel(
            id: movieID,
            name: nil,
            poster: nil,
            year: 0,
            country: nil,
            genres: nil,
            reviews: nil,
            time: 0,
            tagline: nil,
            description: nil,
            director: nil,
            budget: nil,
            fees: nil,
            ageLimit: 0
        )
    }
}

private func sampleMovie(id: String) -> MovieElementModel {
    MovieElementModel(id: id, name: "N", poster: nil, year: 2020, country: nil, genres: nil, reviews: nil)
}

final class GetMoviesUseCaseTests: XCTestCase {
    func testExecuteReturnsNilWhenNoMovies() async throws {
        let repo = MockGetMoviesRepository()
        repo.pages[1] = MoviesPagedListResponseModel(
            movies: [],
            pageInfo: PageInfoModel(pageSize: 10, pageCount: 1, currentPage: 1)
        )
        let sut = GetMoviesUseCaseImpl(repository: repo)

        let first = try await sut.execute()

        XCTAssertNil(first)
        XCTAssertEqual(repo.requestedPages, [1])
    }

    func testExecuteReturnsSingleMovieFromBuffer() async throws {
        let repo = MockGetMoviesRepository()
        let movie = sampleMovie(id: "m1")
        repo.pages[1] = MoviesPagedListResponseModel(
            movies: [movie],
            pageInfo: PageInfoModel(pageSize: 10, pageCount: 1, currentPage: 1)
        )
        let sut = GetMoviesUseCaseImpl(repository: repo)

        let got = try await sut.execute()

        XCTAssertEqual(got?.id, "m1")
        XCTAssertEqual(repo.requestedPages, [1])
    }

    func testExecuteLoadsNextPageWhenBufferDrained() async throws {
        let repo = MockGetMoviesRepository()
        repo.pages[1] = MoviesPagedListResponseModel(
            movies: [sampleMovie(id: "a")],
            pageInfo: PageInfoModel(pageSize: 10, pageCount: 2, currentPage: 1)
        )
        repo.pages[2] = MoviesPagedListResponseModel(
            movies: [sampleMovie(id: "b")],
            pageInfo: PageInfoModel(pageSize: 10, pageCount: 2, currentPage: 2)
        )
        let sut = GetMoviesUseCaseImpl(repository: repo)

        _ = try await sut.execute()
        _ = try await sut.execute()

        XCTAssertEqual(repo.requestedPages, [1, 2])
    }
}
