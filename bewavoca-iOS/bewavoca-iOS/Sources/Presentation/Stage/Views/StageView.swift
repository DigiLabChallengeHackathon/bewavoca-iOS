//
//  StageView.swift
//  bewavoca-iOS
//
//  Created by Muchan Kim on 12/17/24.
//
/*뷰모델에서 값을 받아와서 StageView로 접근할 때 아래 같은 값을 받도록 설정했습니다.
 
 StageView(
 currentStage: viewModel.currentStage   // 뷰모델의 스테이지 값 1~5
 level: viewModel.level                 // 뷰모델의 레벨 값 1~3
 )
 */

import SwiftUI

struct StageView: View {
    @EnvironmentObject private var navigationPathManager : NavigationPathManager
    @State private var selectedStage: Int?
    
    var body: some View {
        DeviceScaledView {
            ZStack {
                Color("myDarkBlue")
                    .ignoresSafeArea()
                
                StageCardView(
                    currentStage: 1,
                    userStage: navigationPathManager.userViewModel.userData.stage,
                    level: navigationPathManager.userViewModel.userData.level,
                    onBackTapped: {
                        navigationPathManager.resetToMainView()
                    },
                    onStageTapped: { stageNumber in
                        switch stageNumber {
                        case 1:
                            navigationPathManager.updateType(to: GameType.ox)
                            navigationPathManager.navigationPath.append(AppDestination.oxGame)
                        case 2:
                            navigationPathManager.updateType(to: GameType.choice)
                            navigationPathManager.navigationPath.append(AppDestination.multipleChoiceGame)
                        case 3:
                            navigationPathManager.updateType(to: GameType.match)
                            navigationPathManager.navigationPath.append(AppDestination.matchingGame)
                        default:
                            return
                        }
                    }
                )
                
                StageTitleView(stage: 1)  // garden은 항상 1스테이지
            }
        }
        .withBackgroundMusic(viewName: String(describing: Self.self))
    }
}

struct StageTitleView: View {
    let stage: Int
    
    var body: some View {
        Image("title_stage_\(stage)")
            .padding(.bottom, 500)
    }
}

#Preview {
    StageView().environmentObject(NavigationPathManager(userViewModel: UserViewModel()))
}
