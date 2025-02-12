protocol GameService {
    func completeGame(
        deviceId: String, 
        region: Int, // 맵 지역
        stage: Int // 맵의 세부 단계
    ) async throws -> APIResponse<GameCompleteResponse>

    func updateCharacter(deviceId: String, characterId: Int) async throws -> APIResponse<CharacterUpdateResponse>
}
