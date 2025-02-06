//
//  AuthService.swift
//  bewavoca-iOS
//
//  Created by Muchan Kim on 2/4/25.
//

import Foundation

protocol AuthService {
    func checkDevice(deviceId: String) async throws -> APIResponse<UserDataResponse>
    func signUp(deviceId: String, nickname: String) async throws -> APIResponse<SignUpResponse>
}
