import SwiftUI

struct StageCardView: View {
    let level: Int
    
    // 뒤로가기 핸들링 함수
    let onBackTapped: () -> Void
    
    // 스테이지 선택 핸들링 함수
    let onStageTapped: (Int) -> Void
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // 흰색 카드 배경
            RoundedRectangle(cornerRadius: 80)
                .fill(Color.white)
                .frame(width: 1237, height: 479)
                .shadow(radius: 10)
                        
            // 뒤로가기 버튼
            Button(action: onBackTapped) {
                Image("button_back")
                    .frame(width: 60, height: 60)
            }
            .padding(.leading, 55)
            .padding(.top, 50)
            
            // 스테이지 버튼들
            /* StageCardView의 스테이지 버튼 구현부
             * 1. ForEach로 1부터 3까지의 스테이지 버튼을 생성
             * 2. 각 버튼이 탭되면 onStageTapped 클로저에 해당 stageNumber를 전달
             * 3. StageItemButton으로 버튼의 외관을 구성하고 현재 상태(완료/현재/잠김)를 표시
             * 4. disabled 수정자로 잠긴 스테이지는 탭 불가능하게 설정
             */
            HStack(spacing: 59) {
                ForEach(1...3, id: \.self) { stageNumber in
                    Button(action: { onStageTapped(stageNumber) }) {
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
