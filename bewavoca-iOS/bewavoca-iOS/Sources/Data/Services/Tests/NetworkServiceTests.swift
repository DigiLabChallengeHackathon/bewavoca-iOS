import Foundation

struct UserDTO: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
}

struct PostDTO: Decodable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

final class NetworkServiceTests {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceImpl.shared) {
        self.networkService = networkService
    }
    
    func testGetUserRequest() async {
        do {
            let user: UserDTO = try await networkService.request(
                endpoint: "/users/3",
                method: .get,
                parameters: nil
            )
            print("✅ GET 요청 성공:")
            print("ID:", user.id)
            print("이름:", user.name)
            print("사용자명:", user.username)
            print("이메일:", user.email)
            print("전화번호:", user.phone)
            print("웹사이트:", user.website)
        } catch {
            print("❌ 사용자 데이터 요청 실패:", error)
        }
    }
    
    func testPostRequest() async {
        do {
            let newPost: PostDTO = try await networkService.request(
                endpoint: "/posts",
                method: .post,
                parameters: [
                    "title": "테스트 게시물",
                    "body": "이것은 테스트 게시물입니다.",
                    "userId": 1
                ]
            )
            print("✅ POST 요청 성공:")
            print("ID:", newPost.id)
            print("제목:", newPost.title)
            print("내용:", newPost.body)
            print("작성자 ID:", newPost.userId)
        } catch {
            print("❌ POST 요청 실패:", error)
        }
    }
}

// MARK: - 테스트 실행
extension NetworkServiceTests {
    func runAllTests() async {
        print("🔍 GET 요청 테스트 시작")
        await testGetUserRequest()
        print("\n🔍 POST 요청 테스트 시작")
        await testPostRequest()
    }
}
