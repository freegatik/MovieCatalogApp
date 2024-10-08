//
//  GetMoviesRepositoryImpl.swift
//  Movarium
//
//  Created by Anton Solovev on 08.10.2024.
//

class GetMoviesRepositoryImpl: GetMoviesRepository {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func getMovies(page: Int) async throws -> MoviesPagedListResponseModel {
        let endpoint = MoviesPagedListEndpoint(page: page)
        return try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)
    }
    
    func getMovieDetails(movieID: String) async throws -> MovieDetailsModel {
        let endpoint = GetMovieDetailsEndpoint(movieID: movieID)
        return try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)
    }
}
