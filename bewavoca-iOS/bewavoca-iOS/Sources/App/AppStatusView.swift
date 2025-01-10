import SwiftUI

// MARK: - AppStatusView
struct AppStatusView: View {
    @StateObject private var navigationPathManager = NavigationPathManager(userViewModel: UserViewModel(isExistingUser: false))
    @State private var isLoadingComplete = false
    
    var body: some View {
        NavigationStack(path: $navigationPathManager.navigationPath) {
            Group {
                if !isLoadingComplete {
                    SplashView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isLoadingComplete = true
                            }
                        }
                } else {
                    LoadingView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                checkUserInfo()
                            }
                        }
                }
            }
            .navigationDestination(for: AppDestination.self) { destination in
                switch destination {
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
    
    private func checkUserInfo() {
        if navigationPathManager.userViewModel.userData.nickname.isEmpty {
            navigationPathManager.navigationPath.append(AppDestination.onboarding)
        } else {
            navigationPathManager.navigationPath.append(AppDestination.main)
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
        self.currentGameInfo = GameInfo(stage: nil, game: nil) // 빈값으로 초기화
        self.currentResultInfo = GameResult(totalCount: 0, correntCount: 0)
    }
    
    func resetGameInfo(stage: Stage? = nil, game: GameType? = nil) {
        self.currentGameInfo = GameInfo(stage: stage, game: game)
    }
    
    func resetResultInfo(totalCount: Int = 0, correntCount: Int = 0) {
        self.currentResultInfo = GameResult(totalCount: totalCount, correntCount: correntCount)
    }
    
    func updateStage(to newStage: Stage?) {
        self.currentGameInfo.stage = newStage
    }
    
    func updateType(to newGame: GameType?) {
        self.currentGameInfo.game = newGame
    }
    
    func updateResultInfo(totalCount: Int, correntCount: Int) {
        self.currentResultInfo = GameResult(totalCount: totalCount, correntCount: correntCount)
    }
}

// MARK: - GameInfo and GameResult
struct GameInfo {
    var stage: Stage?
    var game: GameType?
}

struct GameResult {
    var totalCount: Int
    var correntCount: Int
}

// MARK: - Preview
#Preview {
    AppStatusView()
        .environmentObject(NavigationPathManager(userViewModel: UserViewModel.mock))
}
