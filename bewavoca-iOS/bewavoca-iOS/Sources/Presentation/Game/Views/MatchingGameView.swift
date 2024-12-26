import SwiftUI

struct MatchingGameView: View {
    var body: some View {
        DeviceScaledView {
            ZStack {
                BackgroundRectangleView {
                    NavigationStack {
                        VStack {
                            MatchingGameTopView()
                            
                            MatchingGameBodyView()
                            
                            Spacer()
                        }
                        .background(Color.clear)
                        .padding(.top, 54)
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image("image_match_character_1")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 275)
                    }
                }.padding(-43)
            }
        }
    }
}

struct MatchingGameTopView: View {
    var body: some View {
        HStack {
            NavigationLink(destination: NextSampleGameView(test: "뒤로 가는 페이지")) {
                Image("btn_back")
            }
            
            Spacer()
            
            VStack{
                Text("제주어 짝맞추기")
                    .font(Font.custom("GmarketSansBold", size: 53))
                    .foregroundColor(.black)
                    .padding(.bottom, 21)
                
                Text("표준어와 의미가 같은 제주어를 짝지어 주세요")
                    .font(Font.custom("GmarketSansMedium", size: 20))
                    .foregroundColor(Color("myGrey03"))
            }
            
            Spacer()
            
            Button(action: {
                print("Button clicked")
            }) {
                Image("btn_sound")
            }
        }
        .padding(.top, 50)
        .padding(.horizontal, 50)
        .frame(height: 156)
    }
}

struct MatchingGameBodyView: View {
    @StateObject private var progressBarManager = TimeProgressBarManager(duration: 15, warningTime: 5)
    
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
                    matchedPairs: $matchedPairs
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

#Preview {
    MatchingGameView()
}
