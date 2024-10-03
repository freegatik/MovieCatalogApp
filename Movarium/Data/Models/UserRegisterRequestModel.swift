//
//  UserRegisterModel.swift
//  Movarium
//
//  Created by Anton Solovev on 03.10.2024.
//

struct UserRegisterRequestModel: Codable {
    let userName: String
    let name: String
    let password: String
    let email: String
    let birthDate: String
    let gender: Int
}
