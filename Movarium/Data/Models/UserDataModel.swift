//
//  UserDataModel.swift
//  Movarium
//
//  Created by Anton Solovev on 03.10.2024.
//

struct UserDataResponseModel: Codable {
    let id: String
    let nickName: String
    let email: String
    let avatarLink: String?
    let name: String
    let birthDate: String
    let gender: Int
}

struct UserDataRequestModel: Codable {
    let id: String
    let nickName: String
    let email: String
    let avatarLink: String
    let name: String
    let birthDate: String
    let gender: Int
}
