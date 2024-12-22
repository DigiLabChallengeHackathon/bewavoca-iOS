import SwiftUI

// 추후 스테이지, 게임 종류 등의 ENUM 들을 한 곳에 정리 예정
enum GameType: CaseIterable, CustomStringConvertible {
    case ox, choice, match
    
    var level: Int {
        switch self {
        case .ox: return 1
        case .choice: return 2
        case .match: return 3
        }
    }
    
    var description: String {
        switch self {
        case .ox: return "ox"
        case .choice: return "choice"
        case .match: return "match"
        }
    }
}

struct ResultGameView: View {
    
    @State private var userData = UserData(userId: 4, nickname: "김태인", character: 1, stage: 4, level: 1)
    
    var totalQuestions: Int
    var correctAnswers: Int
    var stage: Stage
    var gameType: GameType
    
    var body: some View {
        NavigationStack {
            DeviceScaledView {
                VStack {
                    Image("text_maintitle")
                        .frame(width: 293, height: 101)
                        .padding(.top, 67)
                        .padding(.bottom, 134)
                    
                    ZStack(alignment: .top) {
                        BackgroundResizeRectangleView(width: 812, height: 554) {
                            VStack {
                                HStack(alignment: .top) {
                                    VStack{
                                        Spacer()
                                        Image("image_result_character_big_1")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 438)
                                            .padding(.trailing, 45)
                                            .padding(.top, 42)
                                    }
                                    
                                    VStack {
                                        Text("\(getGameLevel())단계")
                                            .font(
                                                Font.custom("GmarketSansBold", size: 40)
                                            )
                                            .multilineTextAlignment(.center)
                                            .padding(.top, 43)
                                            .padding(.bottom, 11)
                                        
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(.clear)
                                                .frame(width: 288, height: 83)
                                                .background(Color("myGrey08"))
                                                .cornerRadius(20)
                                            
                                            Text(getResultMessage())
                                                .font(
                                                    Font.custom("GmarketSansBold", size: 50)
                                                )
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(Color("myDarkBlue"))
                                        }
                                        .padding(.bottom, 19)
                                        
                                        Text("정답률 : \(correctAnswers)/\(totalQuestions)")
                                            .font(
                                                Font.custom("Gmarket Sans", size: 40)
                                                    .weight(.bold)
                                            )
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(Color.black)
                                            .padding(.bottom, 32)
                                        
                                        NavigationLink(destination: MainView()) {
                                            Image("btn_confirm")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 288, height: 143)
                                        }
                                        .buttonStyle(EffectButtonStyle())
                                        
                                        Spacer()
                                    }
                                    .padding(.top, 43)
                                }
                                .frame(height: 438)
                                .padding(58)
                            }
                        }
                        
                        Image("image_ribbon_\(stage.description)")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 107)
                            .alignmentGuide(.top) { d in d[.top] }
                            .offset(y: -50)
                    }
                    Spacer()
                }
                .frame(height: 1024)
            }
        }
    }
    
    private func getResultMessage() -> String {
        if correctAnswers >= totalQuestions / 2 {
            return "대단해요"
        } else {
            return "아쉬워요"
        }
    }
    
    private func getGameLevel() -> Int {
        return gameType.level
    }
}

#Preview {
    ResultGameView(totalQuestions: 4, correctAnswers: 2, stage: .meadow, gameType: .match)
}
