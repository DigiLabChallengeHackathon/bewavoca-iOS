import SwiftUI

struct ResultGameView: View {
    @EnvironmentObject private var navigationPathManager: NavigationPathManager
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingRewardView = false
    
    var body: some View {
        DeviceScaledView {
            ResultContentView(
                navigationPathManager: navigationPathManager,
                dismiss: dismiss,
                isShowingRewardView: $isShowingRewardView
            )
        }
        .fullScreenCover(isPresented: $isShowingRewardView) {
            RewardView(characterType: .getCharacterType(for: navigationPathManager.currentGameInfo.stage))
        }
    }
}

struct ResultContentView: View {
    let navigationPathManager: NavigationPathManager
    let dismiss: DismissAction
    @Binding var isShowingRewardView: Bool
    
    var body: some View {
        VStack {
            TitleSection()
            ResultSection(
                navigationPathManager: navigationPathManager,
                dismiss: dismiss,
                isShowingRewardView: $isShowingRewardView
            )
            Spacer()
        }
        .frame(height: 1024)
    }
}

struct TitleSection: View {
    var body: some View {
        Image("text_maintitle")
            .frame(width: 293, height: 101)
            .padding(.top, 67)
            .padding(.bottom, 134)
    }
}

struct ResultSection: View {
    let navigationPathManager: NavigationPathManager
    let dismiss: DismissAction
    @Binding var isShowingRewardView: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            BackgroundResizeRectangleView(width: 812, height: 554) {
                ResultDetailsView(
                    navigationPathManager: navigationPathManager,
                    dismiss: dismiss,
                    isShowingRewardView: $isShowingRewardView
                )
            }
            
            RibbonImage(stage: navigationPathManager.currentGameInfo.stage)
        }
    }
}

struct RibbonImage: View {
    let stage: Stage
    
    var body: some View {
        Image("image_ribbon_\(stage.description)")
            .resizable()
            .scaledToFit()
            .frame(height: 107)
            .alignmentGuide(.top) { d in d[.top] }
            .offset(y: -50)
    }
}

struct ResultDetailsView: View {
    let navigationPathManager: NavigationPathManager
    let dismiss: DismissAction
    @Binding var isShowingRewardView: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack {
                    Spacer()
                    Image("image_result_character_big_\(navigationPathManager.userViewModel.userData.character)")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 438)
                        .padding(.trailing, 45)
                        .padding(.top, 42)
                }
                ResultInfoView(
                    navigationPathManager: navigationPathManager,
                    dismiss: dismiss,
                    isShowingRewardView: $isShowingRewardView
                )
            }
            .frame(height: 438)
            .padding(58)
        }
    }
}


struct ResultInfoView: View {
    let navigationPathManager: NavigationPathManager
    let dismiss: DismissAction
    @Binding var isShowingRewardView: Bool
    
    var body: some View {
        VStack {
            GameLevelText(level: getGameLevel())
            ResultMessageBox(message: getResultMessage())
            ScoreText(result: navigationPathManager.currentResultInfo)
            ConfirmButton(
                navigationPathManager: navigationPathManager,
                dismiss: dismiss,
                isShowingRewardView: $isShowingRewardView
            )
            Spacer()
        }
        .padding(.top, 43)
    }
    
    private func getGameLevel() -> Int {
        return navigationPathManager.currentGameInfo.game.level
    }
    
    private func getResultMessage() -> String {
        if navigationPathManager.currentResultInfo.correntCount >= navigationPathManager.currentResultInfo.totalCount / 2 {
            return "대단해요"
        } else {
            return "아쉬워요"
        }
    }
}

struct GameLevelText: View {
    let level: Int
    
    var body: some View {
        Text("\(level)단계")
            .font(Font.custom("GmarketSansBold", size: 40))
            .multilineTextAlignment(.center)
            .padding(.top, 43)
            .padding(.bottom, 11)
    }
}

struct ResultMessageBox: View {
    let message: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 288, height: 83)
                .background(Color("myGrey08"))
                .cornerRadius(20)
            
            Text(message)
                .font(Font.custom("GmarketSansBold", size: 50))
                .multilineTextAlignment(.center)
                .foregroundColor(Color("myDarkBlue"))
        }
        .padding(.bottom, 19)
    }
}

struct ScoreText: View {
    let result: GameResult
    
    var body: some View {
        Text("정답률 : \(result.correntCount)/\(result.totalCount)")
            .font(
                Font.custom("Gmarket Sans", size: 40)
                    .weight(.bold)
            )
            .multilineTextAlignment(.center)
            .foregroundColor(Color.black)
            .padding(.bottom, 32)
    }
}

struct ConfirmButton: View {
    let navigationPathManager: NavigationPathManager
    let dismiss: DismissAction
    @Binding var isShowingRewardView: Bool
    
    var body: some View {
        Button(action: handleConfirmAction) {
            Image("btn_confirm")
                .resizable()
                .scaledToFill()
                .frame(width: 288, height: 143)
        }
        .buttonStyle(EffectButtonStyle())
    }
    
    private func handleConfirmAction() {
        let correctRatio = Double(navigationPathManager.currentResultInfo.correntCount) / Double(navigationPathManager.currentResultInfo.totalCount)
        
        if correctRatio >= 0.5 {
            let stageIncreased = navigationPathManager.userViewModel.checkAndUpdateProgress(
                clearedStage: navigationPathManager.currentGameInfo.stage.index,
                clearedLevel: navigationPathManager.currentGameInfo.game.level
            )
            if stageIncreased {
                isShowingRewardView = true
            } else {
                navigationPathManager.navigationPath.append(AppDestination.reward)
            }
        } else {
            navigationPathManager.resetToMainView()
        }
    }
}
