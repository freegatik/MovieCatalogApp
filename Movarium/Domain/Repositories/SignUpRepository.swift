//
//  SignUpRepository.swift
//  Movarium
//
//  Created by Anton Solovev on 14.10.2024.
//

protocol SignUpRepository {
    func registerUser(request: UserRegisterRequestModel) async throws -> UserAuthResponseModel
    func saveToken(token: String) throws
}
