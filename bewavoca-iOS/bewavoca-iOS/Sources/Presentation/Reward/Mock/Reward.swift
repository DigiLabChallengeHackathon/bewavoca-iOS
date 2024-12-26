//
//  RewardView.swift
//  bewavoca-iOS
//
//  Created by Moo on 2024/12/22.
//
//  스테이지 클리어 후 보상으로 제공되는 캐릭터 획득 화면입니다.
//  - 첫 페이지: 캐릭터와의 첫 만남과 감사 인사
//  - 두번째 페이지: 캐릭터의 동행 요청과 획득 축하
//  - 마지막: NewCharacterView로 전환되어 캐릭터 획득 완료


enum RewardContent {
    struct Page {
        let message: String
        let characterImage: String
    }
    
    struct RewardScenario {
        let pages: [Page]
    }
    
    static let rewardScenarios: [CharacterType: RewardScenario] = [
        .dongbaek: RewardScenario(pages: [
            Page(
                message: """
                        정말 고마워! 너가 제주어를 발견해준
                        덕분에 정원의 새싹을 지킬 수 있었어.
                        """,
                characterImage: "character_welcome_dongbaek_1"
            ),
            Page(
                message: """
                나도 포기하지 않고 계속 제주를 도울 거야.
                이제부터 너의 모험에 함께 해도 될까?
                """,
                characterImage: "character_welcome_dongbaek_2"
            )
            // 필요하다면 더 많은 페이지 추가 가능
        ])
        // ... 나머지 캐릭터들의 시나리오
    ]
}
