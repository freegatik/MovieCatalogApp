//
//  SignInRepository.swift
//  Movarium
//
//  Created by Anton Solovev on 14.10.2024.
//

protocol SignInRepository {
    func authorizeUser(request: LoginCredentialsRequestModel) async throws -> UserAuthResponseModel
    func saveToken(token: String) throws
}
