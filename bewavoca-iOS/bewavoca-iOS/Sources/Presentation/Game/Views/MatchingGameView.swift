import SwiftUI

struct MatchingGameView: View {
    @State var currentMatchState: CardState = .defaultState
    var body: some View {
        NavigationStack {
            DeviceScaledView {
                ZStack {
                    BackgroundRectangleView {
                        VStack {
                            MatchingGameTopView()
                            MatchingGameBodyView(currentMatchState: $currentMatchState)
                            Spacer()
                        }
                        .background(Color.clear)
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(getCharacterImageName(for: currentMatchState))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 275, height: 338)
                    }
                }
                .frame(width: 1366, height: 1024)
                .padding(.bottom, 41)
                .padding(.trailing, 51)
            }
        }
    }
    
    private func getCharacterImageName(for state: CardState) -> String {
        switch state {
        case .correct:
            return "image_match_character_1_correct"
        case .incorrect:
            return "image_match_character_1_incorrect"
        default:
            return "image_match_character_1_default"
        }
    }
    
    private struct MatchingGameTopView: View {
        var body: some View {
            HStack {
                VStack{
                    NavigationLink(destination: NextSampleGameView(test: "뒤로 가는 페이지")) {
                        Image("btn_back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 78, height: 78)
                    }
                    Spacer()
                }
                
                Spacer()
                
                VStack{
                    Text("제주어 짝맞추기")
                        .font(Font.custom("GmarketSansBold", size: 53))
                        .foregroundColor(.black)
                        .padding(.bottom, 21)
                        .padding(.top, 12)
                    
                    Text("표준어와 의미가 같은 제주어를 짝지어 주세요")
                        .font(Font.custom("GmarketSansMedium", size: 20))
                        .foregroundColor(Color("myGrey03"))
                }
                
                Spacer()
                
                VStack{
                    Button(action: {
                        print("Button clicked")
                    }) {
                        Image("btn_sound")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 78, height: 78)
                    }
                    Spacer()
                }
            }
            .padding(.top, 50)
            .padding(.horizontal, 50)
            .frame(height: 156)
        }
    }
    
    private struct MatchingGameBodyView: View {
        @StateObject private var progressBarManager = TimeProgressBarManager(duration: 15, warningTime: 5)
        
        @Binding var currentMatchState: CardState
        
        let quizzes: [MatchQuiz] = [
            MatchQuiz(matchId: 1, standard: "할아버지", jeju: "하르방"),
            MatchQuiz(matchId: 2, standard: "무지개", jeju: "상고"),
            MatchQuiz(matchId: 3, standard: "고양이", jeju: "깅이"),
            MatchQuiz(matchId: 4, standard: "예쁘다", jeju: "곱다")
        ]
        
        @State private var isGameFinished: Bool = false
        @State private var matchedPairs: Int = 0
        
        var body: some View {
            ZStack {
                VStack {
                    TimeProgressBar(
                        manager: progressBarManager,
                        fillColor: Color("myYellow"),
                        warningColor: Color("myRed"),
                        onComplete: {
                            isGameFinished = true
                        }
                    )
                    .padding(.horizontal, 84)
                    .padding(.bottom, 60)
                    
                    MatchingCardButtonView(
                        quizzes: quizzes,
                        gameOver: $isGameFinished,
                        matchedPairs: $matchedPairs,
                        currentMatchState: $currentMatchState
                    )
                }
                .onAppear {
                    progressBarManager.start()
                }
                .navigationDestination(isPresented: $isGameFinished) {
                    NextSampleGameView(test: "성공여부 -> \(quizzes.count) 중에 \(matchedPairs) 맞춤")
                }
                .padding(.top, 54)
            }
        }
    }
}

#Preview {
    MatchingGameView()
}
