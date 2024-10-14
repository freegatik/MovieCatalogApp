//
//  ReviewsRepository.swift
//  Movarium
//
//  Created by Anton Solovev on 13.10.2024.
//

protocol ReviewsRepository {
    func addReview(movieID: String, request: ReviewRequest) async throws
    func editReview(movieID: String, reviewID: String, request: ReviewRequest) async throws
    func deleteReview(movieID: String, reviewID: String) async throws
}
