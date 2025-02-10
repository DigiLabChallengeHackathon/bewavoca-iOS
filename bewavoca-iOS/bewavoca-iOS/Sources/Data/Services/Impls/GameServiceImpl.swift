//
//  GameServiceImpl.swift
//  bewavoca-iOS
//
//  Created by Muchan Kim on 2/4/25.
//

import Foundation

final class GameServiceImpl: GameService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceImpl.shared) {
        self.networkService = networkService
    }
    
    func completeGame(
        deviceId: String,
        region: Int,
        stage: Int
    ) async throws -> APIResponse<GameCompleteResponse> {
        let parameters: [String: Any] = [
            "deviceId": deviceId,
            "region": region,
            "stage": stage,
            "resultStatus": "GREAT_SUCCESS"  // 성공했을 때만 호출되므로 고정값
        ]
        
        print("🔍 게임 완료 요청 보내기: \(parameters)")
        
        let response: APIResponse<GameCompleteResponse> = try await networkService.request(
            endpoint: APIEndpoints.gameComplete,
            method: .post,
            parameters: parameters
        )
        
        guard response.status == "success", response.data != nil else {
            print("❌ 게임 완료 처리 실패: \(response.status)")
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
        
        return response
    }
}
