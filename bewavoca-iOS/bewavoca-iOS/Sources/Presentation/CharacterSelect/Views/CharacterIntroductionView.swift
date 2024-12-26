//
//  CharacterIntroductionView.swift
//  bewavoca-iOS
//
//  Created by Moo on 2024/12/20.
//
//  선택된 캐릭터의 소개 정보를 표시하는 뷰입니다.
//  - 캐릭터 이미지 표시
//  - 캐릭터 이름과 설명 표시
//  - '함께하기' 버튼을 통한 캐릭터 선택 기능

import SwiftUI

// MARK: - Character Detail View
struct CharacterIntroductionView: View {
    let character: CharacterType  // 표시할 캐릭터 정보
    let currentCharacter: Int     // 현재 선택된 캐릭터 ID (버튼 상태 관리용)
    let updateCharacter: (Int) -> Void  // 캐릭터 선택 시 호출될 콜백
    
    var body: some View {
        HStack(spacing: 55) {
            CharacterImageView(imageName: character.info.selectedImage)
            CharacterInfoView(
                character: character,
                isCurrentCharacter: character.rawValue == currentCharacter,
                updateCharacter: updateCharacter
            )
        }
        .padding(.top, 40)
    }
}

struct CharacterImageView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .frame(width: 350)
            .padding(.top, 10)
    }
}

struct CharacterInfoView: View {
    let character: CharacterType  // 표시할 캐릭터 정보
    let isCurrentCharacter: Bool  // 현재 선택된 캐릭터인지 여부 (버튼 비활성화용)
    let updateCharacter: (Int) -> Void  // 캐릭터 선택 시 호출될 콜백
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text(character.info.name)
                .font(.custom("GmarketSansBold", size: 50))
            
            VStack(alignment: .leading, spacing: 20) {
                Text(character.info.description)
                    .lineSpacing(20)
                    .frame(width: 570, height: 160, alignment: .topLeading)
                    .font(.custom("GmarketSansMedium", size: 25))
                
                Button(action: {
                    updateCharacter(character.rawValue)
                }) {
                    Image("btn_together")
                        .frame(width: 170)
                        .grayscale(isCurrentCharacter ? 1 : 0)
                }
                .disabled(isCurrentCharacter)
            }
        }
        .padding(.top, 30)
    }
}
