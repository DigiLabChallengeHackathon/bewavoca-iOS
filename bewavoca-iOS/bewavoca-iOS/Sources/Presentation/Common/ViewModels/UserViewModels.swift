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
    
    /// ViewModel 초기화
    /// - Parameter isExistingUser: UUID 존재 여부
    init(isExistingUser: Bool) {
        if isExistingUser {
            // UUID가 있는 경우 -> 목데이터 사용 (추후 서버 데이터로 대체)
            self.userData = MockData.user
        } else {
            // 신규 사용자 -> 빈 닉네임으로 초기화
            self.userData = UserData(
                userId: 1,
                nickname: "",
                character: 1,
                stage: 1,
                level: 1
            )
        }
    }
    
    /// 사용자의 닉네임 설정 (신규 사용자용)
    func setNickname(_ nickname: String) {
        userData.nickname = nickname
        // TODO: 서버 연동 시 사용자 생성 API 호출 추가
    }
    
    /// 사용자의 캐릭터 업데이트
    func updateCharacter(newCharacter: Int) {
        userData.character = newCharacter
        // TODO: 서버 연동 시 캐릭터 변경 API 호출 추가
    }
    
    /// 사용자의 스테이지 진행도 업데이트
    func updateStage(newStage: Int) {
        userData.stage = newStage
        // TODO: 서버 연동 시 스테이지 업데이트 API 호출 추가
    }
    
    /// 사용자의 레벨 업데이트
    func updateLevel(newLevel: Int) {
        userData.level = newLevel
        // TODO: 서버 연동 시 레벨 업데이트 API 호출 추가
    }
}
