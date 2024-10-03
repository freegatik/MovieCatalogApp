//
//  MoviesPagedListResponseModel.swift
//  Movarium
//
//  Created by Anton Solovev on 02.10.2024.
//

import Foundation

struct MoviesPagedListResponseModel: Codable {
    let movies: [MovieElementModel]?
    let pageInfo: PageInfoModel
}

struct MovieElementModel: Codable {
    let id: String
    let name: String?
    let poster: String?
    let year: Int
    let country: String?
    let genres: [GenreModel]?
    let reviews: [ReviewShortModel]?
}

struct GenreModel: Codable {
    let id: String
    let name: String?
}

struct ReviewShortModel: Codable {
    let id: String
    let rating: Int
}

struct PageInfoModel: Codable {
    let pageSize: Int
    let pageCount: Int
    let currentPage: Int
}
