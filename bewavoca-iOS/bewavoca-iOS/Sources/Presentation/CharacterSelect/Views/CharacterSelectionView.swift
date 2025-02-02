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
    @EnvironmentObject private var navigationPathManager : NavigationPathManager
    
    @State private var selectedCharacter: CharacterType = .harbang
    
    var body: some View {
        DeviceScaledView {
            ZStack {
                BackgroundView()
                
                VStack(spacing: 50) {
                    CharacterIntroductionView(
                        character: selectedCharacter,
                        currentCharacter: navigationPathManager.userViewModel.userData.character,
                        updateCharacter: { selected in
                            navigationPathManager.userViewModel.userData.character = selected
                        }
                    )
                    CharacterGridView(
                        selectedCharacter: $selectedCharacter,
                        userClearedStage: navigationPathManager.userViewModel.userData.stage
                    )
                }
                
                Button(action: {
                    HapticManager.shared.trigger(.tap)
                    SoundManager.shared.playEffect(.tap)
                    
                    navigationPathManager.resetToMainView()
                }) {
                    Image("btn_x")
                        .frame(width: 78)
                }
                .offset(x: 520, y: -320)
            }
        }
        .onAppear {
            selectedCharacter = CharacterType(rawValue: navigationPathManager.userViewModel.userData.character) ?? .harbang
        }
        .withBackgroundMusic(viewName: String(describing: Self.self))
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CharacterSelectionView()
    }.environmentObject(NavigationPathManager(userViewModel: UserViewModel.mock))
    
}
