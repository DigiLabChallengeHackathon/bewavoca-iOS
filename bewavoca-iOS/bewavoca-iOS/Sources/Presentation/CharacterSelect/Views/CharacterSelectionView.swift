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
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var selectedCharacter: CharacterType = .harbang
    
    var body: some View {
        DeviceScaledView {
            ZStack {
                BackgroundView()
                
                VStack(spacing: 50) {
                    CharacterIntroductionView(
                        character: selectedCharacter,
                        currentCharacter: userViewModel.userData.character,
                        updateCharacter: { selected in
                            userViewModel.userData.character = selected
                        }
                    )
                    CharacterGridView(
                        selectedCharacter: $selectedCharacter,
                        userClearedStage: userViewModel.userData.stage
                    )
                }
                
                DismissButton(dismiss: dismiss)
            }
        }
        .onAppear {
            selectedCharacter = CharacterType(rawValue: userViewModel.userData.character) ?? .harbang
        }
    }
}

// MARK: - Preview
#Preview {
    CharacterSelectionView()
}
