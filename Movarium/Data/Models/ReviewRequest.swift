//
//  ReviewRequest.swift
//  Movarium
//
//  Created by Anton Solovev on 03.10.2024.
//

struct ReviewRequest: Codable {
    let reviewText: String
    let rating: Int
    let isAnonymous: Bool
}
