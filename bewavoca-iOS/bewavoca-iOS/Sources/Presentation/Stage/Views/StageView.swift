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
    @EnvironmentObject private var navigationPathManger : NavigationPathManager
    @Environment(\.dismiss) private var dismiss
    @State private var selectedStage: Int?
    
    var body: some View {
        DeviceScaledView {
            ZStack {
                Color("myDarkBlue")
                    .ignoresSafeArea()
                
                StageCardView(
                    currentStage: 1,
                    userStage: navigationPathManger.userViewModel.userData.stage,
                    level: navigationPathManger.userViewModel.userData.level,
                    onBackTapped: {
                        dismiss()
                    },
                    onStageTapped: { stageNumber in
                        switch stageNumber {
                        case 1:
                            navigationPathManger.updateType(to: GameType.ox)
                            navigationPathManger.navigationPath.append(AppDestination.oxGame)
                        case 2:
                            navigationPathManger.updateType(to: GameType.choice)
                            navigationPathManger.navigationPath.append(AppDestination.multipleChoiceGame)
                        case 3:
                            navigationPathManger.updateType(to: GameType.match)
                            navigationPathManger.navigationPath.append(AppDestination.matchingGame)
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
    StageView().environmentObject(NavigationPathManager(userViewModel: UserViewModel.mock))
}
