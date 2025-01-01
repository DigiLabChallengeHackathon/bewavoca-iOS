// 기본 캐릭터 타입
enum CharacterType: Int, CaseIterable {
    case harbang = 1
    case dongbaek = 2
    case rabong = 3
    case jamneow = 4
    case jejuma = 5
    case halla = 6
    
    var info: CharacterInfo {
        CharacterData.characterInfos[self]!
    }
    
    // 클리어한 스테이지 단계가 캐릭터 해금 요구사항보다 낮을 경우 비활성화
    func isLocked(userClearedStage: Int) -> Bool {
        return info.requiredStage > userClearedStage
    }
}

struct CharacterInfo {
    let name: String
    let description: String
    let selectedImage: String
    let gridImage: String
    let requiredStage: Int
}

// 캐릭터 데이터
enum CharacterData {
    static let characterInfos: [CharacterType: CharacterInfo] = [
        .harbang: CharacterInfo(
            name: "하르방",
            description: """
            안녕! 나는 제주의 수호신, 돌하르방이야.
            제주도에서 많이 나는 돌인 현무암으로 만들어졌지. 
            나는 사람들에게 행운과 번영을 가져다주는 존재야.
            너의 모험이 더 행복하고 안전하도록 도와줄게!
            """,
            selectedImage: "character_selected_dongbaek",
            gridImage: "character_selectList_harbang",
            requiredStage: 1
        ),
        .dongbaek: CharacterInfo(
            name: "동백",
            description: """
            안녕! 나는 제주의 겨울을 밝히는 꽃, 동백이야.
            12월부터 3월까지 춥고 삭막한 제주를 붉게 물들이며
            피어나지. 겨울에도 포기하지 않는 생명력과 따뜻함
            으로 너의 모험에 함께할게.
            """,
            selectedImage: "character_selected_dongbaek",
            gridImage: "character_selectList_dongbaek",
            requiredStage: 2
        ),
        .rabong: CharacterInfo(
            name: "라봉",
            description: "라봉이의 설명...",
            selectedImage: "character_selected_rabong",
            gridImage: "character_selectList_rabong",
            requiredStage: 3
        ),
        .jamneow: CharacterInfo(
            name: "잠녀",
            description: "잠녀의 설명...",
            selectedImage: "character_selected_jamneow",
            gridImage: "character_selectList_jamneow",
            requiredStage: 4
        ),
        .jejuma: CharacterInfo(
            name: "제주마",
            description: "제주마의 설명...",
            selectedImage: "character_selected_jejuma",
            gridImage: "character_selectList_jejuma",
            requiredStage: 5
        ),
        .halla: CharacterInfo(
            name: "한라",
            description: "한라의 설명...",
            selectedImage: "character_selected_halla",
            gridImage: "character_selectList_halla",
            requiredStage: 6
        )
        // ... 다른 캐릭터들의 정보
    ]
}
