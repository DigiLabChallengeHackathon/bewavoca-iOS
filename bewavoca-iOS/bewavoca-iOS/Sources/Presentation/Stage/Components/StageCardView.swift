import SwiftUI

struct StageCardView: View {
    let currentStage: Int      // 현재 보고 있는 스테이지 (garden = 1)
    let userStage: Int         // 유저의 현재 스테이지
    let level: Int
    let onBackTapped: () -> Void
    let onStageTapped: (Int) -> Void
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // 흰색 카드 배경
            RoundedRectangle(cornerRadius: 80)
                .fill(Color.white)
                .frame(width: 1237, height: 479)
                .shadow(radius: 10)
            
            // 뒤로가기 버튼
            Button(action: {
                HapticManager.shared.trigger(.tap)
                SoundManager.shared.playEffect(.tap)
                
                onBackTapped()
            }) {
                Image("button_back")
                    .frame(width: 60, height: 60)
            }
            .padding(.leading, 55)
            .padding(.top, 50)
            
            // 스테이지 버튼들
            HStack(spacing: 59) {
                ForEach(1...3, id: \.self) { stageNumber in
                    Button(action: {
                        HapticManager.shared.trigger(.tap)
                        SoundManager.shared.playEffect(.tap)
                        
                        onStageTapped(stageNumber) }) {
                            StageItemButton(
                                stageNumber: stageNumber,
                                status: getStageStatus(for: stageNumber)
                            )
                        }
                        .disabled(getStageStatus(for: stageNumber) == .locked)
                }
            }
            .padding(.leading, 210)
            .padding(.top, 130)
        }
    }
    
    private func getStageStatus(for stage: Int) -> StageStatus {
        // 유저가 더 높은 스테이지에 있다면 모든 단계가 completed
        if userStage > currentStage {
            return .completed
        }
        
        // 현재 스테이지에서는 level로 상태 결정
        if stage < level {
            return .completed
        } else if stage == level {
            return .current
        } else {
            return .locked
        }
    }
}

// MARK: - StageItemButton
private enum StageStatus {
    case current
    case completed
    case locked
}

private struct StageItemButton: View {
    let stageNumber: Int
    let status: StageStatus
    
    private var backgroundColor: Color {
        switch status {
        case .current:
            return Color("myDarkBlue")
        case .completed:
            return Color("myGrey08")
        case .locked:
            return Color("myGrey04")
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(backgroundColor)
                .frame(width: 232, height: 232)
            
            Text("\(stageNumber)")
                .foregroundColor(status == .completed ? Color("myDarkBlue") : .white)
                .font(.custom("GmarketSansBold", size: 50))
            
            if status == .completed {
                Image("character_stage_dongbaek")
                    .padding(.leading, 150)
                    .padding(.top, 150)
            }
        }
    }
}
