//
//  UserDTO.swift
//  bewavoca-iOS
//
//  Created by Muchan Kim on 2/4/25.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let status: String
    let message: String
    let data: T?
}

struct UserDataResponse: Decodable {
    let userid: Int
    let nickname: String
    let character: Int
    let region: Int
    let level: Int
}

struct SignUpResponse: Decodable {
    let userId: Int
    let nickname: String
}
