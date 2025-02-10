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

struct GameCompleteResponse: Decodable {
    let stage: Int  // 실제로는 level에 매핑될 값
    let region: Int // 실제로는 stage에 매핑될 값
}
