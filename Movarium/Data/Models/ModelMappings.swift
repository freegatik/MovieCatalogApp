//
//  ModelMappings.swift
//  Movarium
//
//  Created by Anton Solovev on 05.05.2026.
//

import Foundation

extension MovieDetailsModel {
    func toDomain(defaultAnonymousName: String, defaultAvatarURL: String) -> MovieDetails {
        let genres: [GenreDetails] = genres?.compactMap { genre in
            guard let genre else { return nil }
            return GenreDetails(id: genre.id, name: genre.name ?? SC.empty)
        } ?? []

        let reviews: [ReviewDetails] = reviews?.compactMap { review in
            guard let review else { return nil }
            return ReviewDetails(
                id: review.id,
                rating: review.rating,
                reviewText: review.reviewText ?? SC.empty,
                isAnonymous: review.isAnonymous,
                createDateTime: review.createDateTime,
                author: AuthorDetails(
                    userId: review.author?.userId ?? SC.empty,
                    nickName: review.author?.nickName ?? defaultAnonymousName,
                    avatar: review.author?.avatar ?? defaultAvatarURL
                )
            )
        } ?? []

        return MovieDetails(
            id: id,
            name: name ?? SC.empty,
            poster: poster ?? SC.empty,
            year: year,
            country: country ?? SC.empty,
            genres: genres,
            reviews: reviews,
            time: time,
            tagline: tagline ?? SC.empty,
            description: description ?? SC.empty,
            director: director ?? SC.empty,
            budget: budget ?? 0,
            fees: fees ?? 0,
            ageLimit: ageLimit
        )
    }
}

extension UserDataResponseModel {
    func toDomain(defaultProfileImageURL: String) -> UserData {
        UserData(
            id: id,
            username: nickName,
            email: email,
            profileImageURL: avatarLink ?? defaultProfileImageURL,
            name: name,
            birthDate: birthDate,
            gender: Gender(rawValue: gender) ?? .male
        )
    }
}

extension UserData {
    func toRequestModel() -> UserDataRequestModel {
        UserDataRequestModel(
            id: id,
            nickName: username,
            email: email,
            avatarLink: profileImageURL,
            name: name,
            birthDate: birthDate,
            gender: gender.rawValue
        )
    }
}
