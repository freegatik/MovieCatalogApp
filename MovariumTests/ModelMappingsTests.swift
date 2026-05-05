//
//  ModelMappingsTests.swift
//  MovariumTests
//
//  Created by Anton Solovev on 05.05.2026.
//

import XCTest
@testable import Movarium

final class ModelMappingsTests: XCTestCase {
    func testMovieDetailsModelToDomainMapsNestedValuesAndFallbacks() {
        let sut = MovieDetailsModel(
            id: "movie-1",
            name: nil,
            poster: nil,
            year: 2026,
            country: nil,
            genres: [
                Genre(id: "g1", name: "Drama"),
                nil,
                Genre(id: "g2", name: nil)
            ],
            reviews: [
                nil,
                ReviewModel(
                    id: "r1",
                    rating: 5,
                    reviewText: nil,
                    isAnonymous: true,
                    createDateTime: "2026-05-05T17:20:00Z",
                    author: Author(userId: "u1", nickName: nil, avatar: nil)
                ),
                ReviewModel(
                    id: "r2",
                    rating: 3,
                    reviewText: "ok",
                    isAnonymous: false,
                    createDateTime: "2026-05-05T18:00:00Z",
                    author: nil
                )
            ],
            time: 120,
            tagline: nil,
            description: nil,
            director: nil,
            budget: nil,
            fees: nil,
            ageLimit: 16
        )

        let domain = sut.toDomain(
            defaultAnonymousName: "Anonymous",
            defaultAvatarURL: "https://avatar.test/default.png"
        )

        XCTAssertEqual(domain.id, "movie-1")
        XCTAssertEqual(domain.name, "")
        XCTAssertEqual(domain.poster, "")
        XCTAssertEqual(domain.country, "")
        XCTAssertEqual(domain.tagline, "")
        XCTAssertEqual(domain.description, "")
        XCTAssertEqual(domain.director, "")
        XCTAssertEqual(domain.budget, 0)
        XCTAssertEqual(domain.fees, 0)
        XCTAssertEqual(domain.genres.count, 2)
        XCTAssertEqual(domain.genres[0].id, "g1")
        XCTAssertEqual(domain.genres[0].name, "Drama")
        XCTAssertEqual(domain.genres[1].id, "g2")
        XCTAssertEqual(domain.genres[1].name, "")
        XCTAssertEqual(domain.reviews.count, 2)
        XCTAssertEqual(domain.reviews[0].reviewText, "")
        XCTAssertEqual(domain.reviews[0].author.userId, "u1")
        XCTAssertEqual(domain.reviews[0].author.nickName, "Anonymous")
        XCTAssertEqual(domain.reviews[0].author.avatar, "https://avatar.test/default.png")
        XCTAssertEqual(domain.reviews[1].author.userId, "")
        XCTAssertEqual(domain.reviews[1].author.nickName, "Anonymous")
        XCTAssertEqual(domain.reviews[1].author.avatar, "https://avatar.test/default.png")
    }

    func testUserDataResponseModelToDomainFallsBackAvatarAndUnknownGenderDefaultsToMale() {
        let sut = UserDataResponseModel(
            id: "user-1",
            nickName: "anton",
            email: "anton@example.com",
            avatarLink: nil,
            name: "Anton",
            birthDate: "2000-01-01",
            gender: 99
        )

        let domain = sut.toDomain(defaultProfileImageURL: "https://avatar.test/profile.png")

        XCTAssertEqual(domain.id, "user-1")
        XCTAssertEqual(domain.username, "anton")
        XCTAssertEqual(domain.email, "anton@example.com")
        XCTAssertEqual(domain.profileImageURL, "https://avatar.test/profile.png")
        XCTAssertEqual(domain.name, "Anton")
        XCTAssertEqual(domain.birthDate, "2000-01-01")
        XCTAssertEqual(domain.gender, .male)
    }

    func testUserDataToRequestModelPreservesEditableFields() {
        let sut = UserData(
            id: "user-2",
            username: "nickname",
            email: "mail@example.com",
            profileImageURL: "https://avatar.test/custom.png",
            name: "Name",
            birthDate: "1999-03-04",
            gender: .female
        )

        let request = sut.toRequestModel()

        XCTAssertEqual(request.id, "user-2")
        XCTAssertEqual(request.nickName, "nickname")
        XCTAssertEqual(request.email, "mail@example.com")
        XCTAssertEqual(request.avatarLink, "https://avatar.test/custom.png")
        XCTAssertEqual(request.name, "Name")
        XCTAssertEqual(request.birthDate, "1999-03-04")
        XCTAssertEqual(request.gender, 1)
    }
}
