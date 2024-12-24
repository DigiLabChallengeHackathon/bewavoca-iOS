//
//  UnlockContent.swift
//  bewavoca-iOS
//
//  Created by Moo on 2024/12/22.
//
//  캐릭터 해금 화면에 사용되는 데이터 모델입니다.
//  - 캐릭터별 해금 축하 이미지
//  - 추후 캐릭터별 해금 메시지나 효과음 등 추가 가능

enum UnlockedCharacterContent {
    struct Character {
        let unlockImage: String
    }
    
    static let characters: [CharacterType: Character] = [
        .dongbaek: Character(
            unlockImage: "character_unlock_dongbaek"
        ),
        .rabong: Character(
            unlockImage: "character_unlock_rabong"
        ),
        // ... 나머지 캐릭터들
    ]
}
