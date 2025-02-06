import SwiftUI

// MARK: - AppStatusView
struct AppStatusView: View {
    @StateObject private var navigationPathManager = NavigationPathManager(userViewModel: UserViewModel())
    @State private var isLoadingComplete = false
    
    // 인증 관련 추가
    @AppStorage("userUUID") private var userUUID: String?
    @State private var isNewUser = true
    private let authService: AuthService = AuthServiceImpl()
    
    var body: some View {
        NavigationStack(path: $navigationPathManager.navigationPath) {
            Group {
                if !isLoadingComplete {
                    SplashView()
                        .onAppear {
                            checkDeviceAndProceed()
                        }
                } else {
                    if isNewUser {
                        OnboardingView()
                    } else {
                        LoadingView()
                    }
                }
            }
            .navigationDestination(for: AppDestination.self) { destination in
                switch destination {
                case .loading:
                    LoadingView()
                case .main:
                    MainView()
                case .onboarding:
                    OnboardingView()
                case .stage:
                    StageView()
                case .setting:
                    NextSampleGameView(test: "빈 페이지")
                case .characterSelect:
                    CharacterSelectionView()
                case .oxGame:
                    OXGameView()
                case .multipleChoiceGame:
                    MultipleChoiceGameView()
                case .matchingGame:
                    MatchingGameView()
                case .resultGame:
                    ResultGameView()
                case .reward:
                    RewardView(characterType: .dongbaek)
                }
            }
        }
        .environmentObject(navigationPathManager)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    private func checkDeviceAndProceed() {
        if userUUID == nil {
            userUUID = UUID().uuidString
        }
        
        Task {
            do {
                let response = try await authService.checkDevice(deviceId: userUUID ?? "")
                guard let userData = response.data else {
                    isNewUser = true
                    print("❌ 사용자 데이터가 없음")
                    isLoadingComplete = true
                    return
                }
                
                isNewUser = false
                
                DispatchQueue.main.async {
                    navigationPathManager.userViewModel.userData = UserData(
                        userId: userData.userid,
                        nickname: userData.nickname,
                        character: userData.character,
                        stage: userData.region,
                        level: userData.level
                    )
                    isLoadingComplete = true
                }
                
                print("✅ 디바이스 체크 성공 및 사용자 데이터 불러오기: \(userData)")
            } catch {
                isNewUser = true
                print("❌ 디바이스 체크 실패: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    isLoadingComplete = true
                }
            }
        }
    }
}

// MARK: - NavigationPathManager
class NavigationPathManager: ObservableObject {
    @Published var navigationPath: NavigationPath = NavigationPath() // 네비게이션 경로
    @Published var currentGameInfo: GameInfo // 현재 진행 중인 게임 정보
    @Published var currentResultInfo: GameResult // 게임 결과
    @Published var userViewModel: UserViewModel
    
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
        self.currentGameInfo = GameInfo(stage: .garden, game: .ox)
        self.currentResultInfo = GameResult(totalCount: 0, correntCount: 0)
    }
    
    func resetToLoadingView() { // LoadingView -> MainView 이동
        navigationPath.removeLast(navigationPath.count) // 네비게이션 스택 초기화
        navigationPath.append(AppDestination.loading)
    }
    
    func resetToMainView(){
        navigationPath.removeLast(navigationPath.count-1) // 네비게이션 스택을 LoadingView 로
        navigationPath.append(AppDestination.main)
    }
    
    func resetGameInfo() {
        self.currentGameInfo = GameInfo(stage: .garden, game: .ox)
    }
    
    func resetResultInfo(totalCount: Int = 0, correntCount: Int = 0) {
        self.currentResultInfo = GameResult(totalCount: totalCount, correntCount: correntCount)
    }
    
    func updateStage(to newStage: Stage) {
        self.currentGameInfo.stage = newStage
    }
    
    func updateType(to newGame: GameType) {
        self.currentGameInfo.game = newGame
    }
    
    func updateResultInfo(totalCount: Int, correntCount: Int) {
        self.currentResultInfo = GameResult(totalCount: totalCount, correntCount: correntCount)
    }
}

// MARK: - GameInfo and GameResult
struct GameInfo {
    var stage: Stage
    var game: GameType
}

struct GameResult {
    var totalCount: Int
    var correntCount: Int
}

// MARK: - Preview
//#Preview {
//    AppStatusView()
//        .environmentObject(NavigationPathManager(userViewModel: UserViewModel.mock))
//}
