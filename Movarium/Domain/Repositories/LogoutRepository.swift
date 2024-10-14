//
//  LogoutRepository.swift
//  Movarium
//
//  Created by Anton Solovev on 13.10.2024.
//

protocol LogoutRepository {
    func logout() async throws -> UserAuthResponseModel
    func removeToken() throws
}
