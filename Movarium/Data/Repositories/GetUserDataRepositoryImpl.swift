//
//  GetUserDataRepositoryImpl.swift
//  Movarium
//
//  Created by Anton Solovev on 08.10.2024.
//

class GetUserDataRepositoryImpl: GetUserDataRepository {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func getUserData() async throws -> UserDataResponseModel {
        let endpoint = UserDataEndpoint()
        return try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)
    }
}
