import Foundation

enum HTTPMethod {
    case get
    case post
    case put
    case delete
}

protocol NetworkService {
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod, // 커스텀 HTTPMethod 사용
        parameters: [String: Any]?
    ) async throws -> T
}
