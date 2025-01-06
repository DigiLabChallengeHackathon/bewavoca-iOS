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
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var selectedStage: Int?
    
    var body: some View {
        DeviceScaledView {
            ZStack {
                Color("myDarkBlue")
                    .ignoresSafeArea()
                
                StageCardView(
                    currentStage: 1,
                    userStage: userViewModel.userData.stage,
                    level: userViewModel.userData.level,
                    onBackTapped: {
                        dismiss()
                    },
                    onStageTapped: { stageNumber in
                        selectedStage = stageNumber
                    }
                )
                
                StageTitleView(stage: 1)  // garden은 항상 1스테이지
            }
            .navigationDestination(isPresented: Binding(
                get: { selectedStage != nil },
                set: { if !$0 { selectedStage = nil } }
            )) {
                if let stage = selectedStage {
                    switch stage {
                    case 1:
                        OXGameView(stage: .garden)
                    case 2:
                        MultipleChoiceGameView(stage: .garden)
                    case 3:
                        MatchingGameView(stage: .garden)
                    default:
                        EmptyView()
                    }
                }
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
    StageView()
        .environmentObject(UserViewModel.mock)
}
