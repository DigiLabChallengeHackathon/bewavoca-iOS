//
//  UserViewModels.swift
//  bewavoca-iOS
//
//  Created by Muchan Kim on 12/30/24.
//

import Foundation

final class UserViewModel: ObservableObject {
    /// 사용자 데이터를 관리하는 Published 프로퍼티
    @Published var userData: UserData
    private var deviceId: String {
        UserDefaults.standard.string(forKey: "userUUID") ?? ""
    }
    
    /// ViewModel 초기화
    init() {
        self.userData = UserData(
            userId: 0,
            nickname: "",
            character: 1,
            stage: 1,
            level: 1
        )
    }
    
    /// 사용자의 닉네임 설정 (신규 사용자용)
    func setNickname(_ nickname: String) async throws {
        let authService = AuthServiceImpl()
        let response = try await authService.signUp(deviceId: deviceId, nickname: nickname)
        guard let signUpData = response.data else {
            throw AuthError.invalidResponse
        }
        
        DispatchQueue.main.async {
            self.userData.userId = signUpData.userId
            self.userData.nickname = signUpData.nickname
        }
    }
    
    /// 게임 완료 처리 및 진행도 업데이트
    func completeGame(region: Int, stage: Int) async throws -> Bool {
        let gameService = GameServiceImpl()
        let response = try await gameService.completeGame(
            deviceId: deviceId,
            region: region,
            stage: stage
        )
        
        guard let data = response.data else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
        }
        
        DispatchQueue.main.async {
            self.userData.stage = data.region
            self.userData.level = data.stage
        }
        
        return data.region > region
    }
    
    /// 사용자의 캐릭터 업데이트
    func updateCharacter(newCharacter: Int) {
        userData.character = newCharacter
        // TODO: 서버 연동 시 캐릭터 변경 API 호출 추가
    }
}
