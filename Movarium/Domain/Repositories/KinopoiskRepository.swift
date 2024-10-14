//
//  KinopoiskRepository.swift
//  Movarium
//
//  Created by Anton Solovev on 13.10.2024.
//

protocol KinopoiskRepository {
    func getKinopoiskDetails(yearFrom: Int, yearTo: Int, keyword: String) async throws -> FilmSearchByFiltersResponse
    func getDirectorPoster(name: String) async throws -> PersonByNameResponse
}
