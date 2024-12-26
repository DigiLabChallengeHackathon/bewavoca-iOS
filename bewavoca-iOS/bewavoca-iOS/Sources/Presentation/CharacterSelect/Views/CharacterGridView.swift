//
//  CharacterGridView.swift
//  bewavoca-iOS
//
//  Created by Moo on 2024/12/20.
//
//  하단의 캐릭터 선택 그리드를 표시하는 뷰입니다.
//  - 전체 캐릭터 목록을 그리드 형태로 표시
//  - 캐릭터 잠금 상태 표시
//  - 현재 선택된 캐릭터 하이라이트 표시

import SwiftUI

// MARK: - Character Grid View
struct CharacterGridView: View {
    // 선택된 캐릭터 바인딩 (양방향 데이터 바인딩)
    @Binding var selectedCharacter: CharacterType
    // 사용자가 클리어한 스테이지 (캐릭터 잠금 상태 확인용)
    let userClearedStage: Int
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(CharacterType.allCases, id: \.self) { character in
                CharacterGridButton(
                    character: character,
                    isSelected: selectedCharacter == character,
                    isLocked: character.isLocked(userClearedStage: userClearedStage)
                ) {
                    selectedCharacter = character
                }
            }
        }
    }
}

struct CharacterGridButton: View {
    let character: CharacterType  // 표시할 캐릭터
    let isSelected: Bool         // 현재 선택된 상태인지
    let isLocked: Bool          // 잠금 상태인지
    let action: () -> Void      // 버튼 탭 시 실행될 액션
    
    var body: some View {
        Button(action: {
            if !isLocked {
                action()
            }
        }) {
            CharacterGridItem(
                character: character,
                isLocked: isLocked,
                isSelected: isSelected
            )
        }
        .disabled(isLocked)
    }
}

// MARK: - Grid Item View
struct CharacterGridItem: View {
    let character: CharacterType  // 표시할 캐릭터
    let isLocked: Bool          // 잠금 상태 (회색조 처리용)
    let isSelected: Bool        // 선택 상태 (테두리 표시용)
    
    var body: some View {
        Image(character.info.gridImage)
            .frame(width: 145, height: 145)
            .background(Color("myGrey08"))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("myDarkBlue"), lineWidth: isSelected ? 10 : 0)
            )
            .grayscale(isLocked ? 1 : 0)
            .brightness(isLocked ? -0.45 : 0)
            .contrast(isLocked ? 1.2 : 1)
    }
}
