//
//  SignUpRepositoryImpl.swift
//  Movarium
//
//  Created by Anton Solovev on 10.10.2024.
//

import KeychainAccess

class SignUpRepositoryImpl: SignUpRepository {
    private let httpClient: HTTPClient
    private let keychain: Keychain
    
    init(httpClient: HTTPClient, keychain: Keychain) {
        self.httpClient = httpClient
        self.keychain = keychain
    }
    
    func registerUser(request: UserRegisterRequestModel) async throws -> UserAuthResponseModel {
        let endpoint = UserRegisterEndpoint()
        return try await httpClient.sendRequest(endpoint: endpoint, requestBody: request)
    }
    
    func saveToken(token: String) throws {
        try keychain.set(token, key: "authToken")
    }
}
