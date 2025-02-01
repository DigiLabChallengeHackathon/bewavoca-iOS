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
    init() {
        self.userData = UserData(
            userId: 0,
            nickname: "",
            character: 1,
            region: 1,
            level: 1
        )
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
        userData.region = newStage
        // TODO: 서버 연동 시 스테이지 업데이트 API 호출 추가
    }
    
    /// 사용자의 레벨 업데이트
    func updateLevel(newLevel: Int) {
        userData.level = newLevel
        // TODO: 서버 연동 시 레벨 업데이트 API 호출 추가
    }
    
    /// 스테이지 클리어 시 진행도 업데이트
    /// - Returns: 스테이지가 올라갔으면 true, 아니면 false
    func checkAndUpdateProgress(clearedStage: Int, clearedLevel: Int) -> Bool {
        guard clearedStage == userData.region else { return false }
        guard clearedLevel == userData.level else { return false }
        
        if userData.level == 3 {  // 현재 레벨이 3(최고 레벨)인 경우
            let previousStage = userData.region
            updateStage(newStage: userData.region + 1)  // 다음 스테이지로
            updateLevel(newLevel: 1)  // 레벨 1로 초기화
            
            return userData.region > previousStage  // 스테이지가 올라갔는지 여부 반환
        } else {  // 현재 레벨이 1 또는 2인 경우
            updateLevel(newLevel: userData.level + 1)  // 다음 레벨로
            return false
        }
    }
}
