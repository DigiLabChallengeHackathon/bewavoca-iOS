import Foundation

protocol AuthService {
    func checkDevice(deviceId: String) async throws -> APIResponse<UserDataResponse>
    func signUp(deviceId: String, nickname: String) async throws -> APIResponse<SignUpResponse>
}
