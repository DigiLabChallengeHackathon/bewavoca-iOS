import Foundation
import Alamofire

final class AuthServiceImpl: AuthService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceImpl.shared) {
        self.networkService = networkService
    }
    // 디바이스 체크
    func checkDevice(deviceId: String) async throws -> APIResponse<UserDataResponse> {
        let parameters: [String: Any] = ["deviceId": deviceId]
        
        print("🔍 디바이스 체크 요청 보내기: \(deviceId)")
        
        let response: APIResponse<UserDataResponse> = try await networkService.request(
            endpoint: APIEndpoints.checkDevice,
            method: .post,
            parameters: parameters
        )
                
        guard response.status == "success", response.data != nil else {
            print("❌ 디바이스 체크 실패: \(response.status)")
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
        
        return response
    }
    
    // 회원가입
    func signUp(deviceId: String, nickname: String) async throws -> APIResponse<SignUpResponse> {
        let parameters: [String: Any] = [
            "deviceId": deviceId,
            "nickname": nickname
        ]
        
        print("🔍 회원가입 요청 보내기: \(nickname)")
        
        let response: APIResponse<SignUpResponse> = try await networkService.request(
            endpoint: APIEndpoints.signUp,
            method: .post,
            parameters: parameters
        )
        
        print("🔍 회원가입 응답 결과: \(response)")
        
        guard response.status == "success", response.data != nil else {
            print("❌ 회원가입 실패: \(response.status)")
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
        
        return response
    }
}
