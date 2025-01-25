import Alamofire

final class NetworkServiceImpl: NetworkService {
    static let shared = NetworkServiceImpl()
    private let baseURL = Config.baseURL
    
    private init() {}
    
    private let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]? = nil
    ) async throws -> T {
        let url = "\(baseURL)\(endpoint)"
        
        // 커스텀 HTTPMethod -> Alamofire.HTTPMethod 변환
        let alamofireMethod: Alamofire.HTTPMethod
        switch method {
        case .get:
            alamofireMethod = .get
        case .post:
            alamofireMethod = .post
        case .put:
            alamofireMethod = .put
        case .delete:
            alamofireMethod = .delete
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                method: alamofireMethod,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: headers
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
