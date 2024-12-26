//
//  CharacterSelectView.swift
//  bewavoca-iOS
//
//  Created by Moo on 2024/12/20.
//
//  캐릭터 선택 화면의 메인 뷰입니다.
//  - 전체 레이아웃 구성 및 상태 관리
//  - 캐릭터 선택 시 상위 뷰로 데이터 전달
//  - 사용자의 스테이지 진행도에 따른 캐릭터 잠금 관리

import SwiftUI

struct CharacterSelectionView: View {
    // 뷰 닫기 액션을 위한 환경 변수
    @Environment(\.dismiss) private var dismiss
    
    // 사용자가 클리어한 최고 스테이지 번호 (캐릭터 잠금 해제 조건으로 사용)
    let userClearedStage: Int
    
    // 현재 사용자가 선택한 캐릭터의 ID
    let currentCharacter: Int
    
    // 현재 화면에서 선택된 캐릭터 (UI 상태 관리)
    @State private var selectedCharacter: CharacterType
    
    // 캐릭터 선택 시 호출될 콜백 함수 (선택된 캐릭터 ID를 상위 뷰에 전달)
    let updateCharacter: (Int) -> Void
    
    init(
        userClearedStage: Int,  // 사용자가 클리어한 최고 스테이지
        currentCharacter: Int,   // 현재 선택된 캐릭터 ID
        updateCharacter: @escaping (Int) -> Void  // 캐릭터 업데이트 콜백
    ) {
        self.userClearedStage = userClearedStage
        self.currentCharacter = currentCharacter
        self.updateCharacter = updateCharacter
        // 현재 캐릭터 ID로 CharacterType을 초기화, 실패시 기본값으로 harbang 사용
        _selectedCharacter = State(initialValue: CharacterType(rawValue: currentCharacter) ?? .harbang)
    }
    
    var body: some View {
        DeviceScaledView {
            ZStack {
                BackgroundView()
                
                VStack(spacing: 50) {
                    CharacterIntroductionView(
                        character: selectedCharacter,
                        currentCharacter: currentCharacter,
                        updateCharacter: updateCharacter
                    )
                    CharacterGridView(
                        selectedCharacter: $selectedCharacter,
                        userClearedStage: userClearedStage
                    )
                }
                
                DismissButton(dismiss: dismiss)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    CharacterSelectionView(userClearedStage: 5, currentCharacter: 1, updateCharacter: { _ in })
}
