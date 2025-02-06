enum AuthError: Error {
    case invalidResponse
    case deviceCheckFailed
    case signUpFailed
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "서버 응답이 올바르지 않습니다."
        case .deviceCheckFailed:
            return "디바이스 확인에 실패했습니다."
        case .signUpFailed:
            return "회원가입에 실패했습니다."
        case .unknownError:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
} 
