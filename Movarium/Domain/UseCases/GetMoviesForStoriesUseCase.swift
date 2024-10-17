//
//  GetMoviesForStoriesUseCase.swift
//  Movarium
//
//  Created by Anton Solovev on 16.10.2024.
//

protocol GetMoviesForStoriesUseCase {
    func execute() async throws -> [MovieElementModel]
}

class GetMoviesForStoriesUseCaseImpl: GetMoviesForStoriesUseCase {
    private let repository: GetMoviesRepository
    
    private var page = 1
    
    init(repository: GetMoviesRepository) {
        self.repository = repository
    }
    
    static func create() -> GetMoviesForStoriesUseCaseImpl {
        let httpClient = AlamofireHTTPClient(baseURL: .kreosoft)
        let repository = GetMoviesRepositoryImpl(httpClient: httpClient)
        return GetMoviesForStoriesUseCaseImpl(repository: repository)
    }
    
    func execute() async throws -> [MovieElementModel] {
        let movies = try await repository.getMovies(page: page)
        
        return Array(movies.movies?.prefix(5) ?? [])
    }
}
