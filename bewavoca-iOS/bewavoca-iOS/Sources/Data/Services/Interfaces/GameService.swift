protocol GameService {
    func completeGame(
        deviceId: String, 
        region: Int, // 맵 지역
        stage: Int // 맵의 세부 단계
    ) async throws -> APIResponse<GameCompleteResponse>
}
