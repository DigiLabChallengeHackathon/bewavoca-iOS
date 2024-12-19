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
    @State private var selectedStage: Int? // 버튼 선택
    let level: Int // 현재 스테이지 레벨
    let currentStage: Int = 1 // 현재 맵 위치
    
    // 뷰모델으로 level 값 초기화
    init(level: Int = 2) {
        self.level = level
    }
    
    var body: some View {
        DeviceScaledView {
            ZStack {
                Color("myDarkBlue")
                    .ignoresSafeArea()
                
                StageCardView(
                    level: level,
                    // 검색해보니 뒤로가기는 Enviroment변수로 접근해야하는데, 이건 추후에 연결 할 때 작업하는게 좋을 것 같습니다. 임시뷰랑 연결해놨습니다.
                    /* StageCardView에 전달할 이벤트 핸들러 정의
                     * 1. onBackTapped: 뒤로가기 버튼 탭 시 BackView로 이동
                     * 2. onStageTapped: 스테이지 버튼 탭 시 전달받은 stageNumber를 selectedStage에 저장
                     *    - 이 값이 설정되면 아래의 navigationDestination이 활성화됨
                     */
                    onBackTapped: {
                        _ = NavigationLink("", destination: BackView())
                    },
                    onStageTapped: { stageNumber in
                        selectedStage = stageNumber
                    }
                )
                
                StageTitleView(stage: currentStage)
            }
            /* 네비게이션 목적지 설정
             * 1. Binding을 통해 selectedStage 값의 유무를 감시
             *    - get: selectedStage가 nil이 아니면 네비게이션 활성화
             *    - set: 뒤로가기 시 selectedStage를 nil로 리셋
             * 2. selectedStage 값에 따라 해당하는 게임 뷰로 이동
             *    - 1: OXGameView
             *    - 2: FourChoiceGameView
             *    - 3: CardGameView
             */
            .navigationDestination(isPresented: Binding(
                get: { selectedStage != nil },
                set: { if !$0 { selectedStage = nil } }
            )) {
                if let stage = selectedStage {
                    switch stage {
                    case 1:
                        OXGameView()
                    case 2:
                        FourChoiceGameView()
                    case 3:
                        CardGameView()
                    default:
                        EmptyView()
                    }
                }
            }
        }
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
    StageView(level: 1)
}
