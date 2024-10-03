//
//  PersonByNameResponse.swift
//  Movarium
//
//  Created by Anton Solovev on 03.10.2024.
//

struct PersonByNameResponse: Codable {
    let total: Int
    let items: [PersonItem]
}

struct PersonItem: Codable {
    let kinopoiskId: Int
    let webUrl: String
    let nameRu: String?
    let nameEn: String?
    let sex: Sex?
    let posterUrl: String
}

enum Sex: String, Codable {
    case male = "MALE"
    case female = "FEMALE"
    case unknown = "UNKNOWN"
}
