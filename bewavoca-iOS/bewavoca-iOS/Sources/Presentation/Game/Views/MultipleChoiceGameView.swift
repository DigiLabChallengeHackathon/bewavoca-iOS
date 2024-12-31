import SwiftUI

struct MultipleChoiceGameView: View {
    var body: some View {
        DeviceScaledView {
            BackgroundRectangleView {
                NavigationStack{
                    VStack {
                        MultipleGameTopView()
                        MultipleGameBodyView()
                        Spacer()
                    }
                    .background(Color.clear)
                }
            }
        }
    }
    
    private struct MultipleGameTopView: View {
        var body: some View {
            HStack {
                // 1. NavigationLink (왼쪽 정렬)
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
                    Text("제주어 4지선다")
                        .font(Font.custom("GmarketSansBold", size: 53))
                        .foregroundColor(.black)
                        .padding(.bottom, 21)
                        .padding(.top, 12)
                    
                    Text("제시된 4개의 선지 중 맞는 선지를 고르세요!")
                        .font(Font.custom("GmarketSansMedium", size: 20))
                        .foregroundColor(Color("myGrey03"))
                }
                
                Spacer()
                
                // 3. ImageButton (우측 정렬)
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
                //            .hidden()
            }
            .padding(.top, 50)
            .padding(.horizontal, 50)
            .frame(height: 156)
        }
    }

    private struct MultipleGameBodyView: View {
        @State private var currentQuizIndex: Int = 0
        @State private var selectedAnswer: Int? = nil
        @State private var correctCount: Int = 0
        
        @StateObject private var progressBarManager = TimeProgressBarManager(duration: 15, warningTime: 5)
        
        @State private var isTimeOver: Bool = false
        
        let quizzes: [ChoiceQuiz] = [
            ChoiceQuiz(choiceId: 15, question: "노란색이고 달콤한 과일은?", options: ["바나나", "사과", "키위", "포도"], correctAnswer: "바나나", explanation: "노란색이고 달콤한 과일은 바나나입니다.", voice: "banana_audio"),
            ChoiceQuiz(choiceId: 16, question: "빨간색 껍질을 가진 과일은?", options: ["딸기", "사과", "복숭아", "배"], correctAnswer: "사과", explanation: "빨간색 껍질을 가진 과일은 사과입니다.", voice: "apple_audio"),
            ChoiceQuiz(choiceId: 17, question: "신 맛이 강한 노란 과일은?", options: ["레몬", "바나나", "포도", "복숭아"], correctAnswer: "레몬", explanation: "신 맛이 강한 노란 과일은 레몬입니다.", voice: "lemon_audio")
        ]
        
        @State private var isButtonDisabled: Bool = false
        @State private var isGameFinished: Bool = false
        
        var body: some View {
            VStack {
                // Progress Bar
                TimeProgressBar(
                    manager: progressBarManager,
                    fillColor: Color("myYellow"),
                    warningColor: Color("myRed"),
                    onComplete: {
                        self.isTimeOver = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.isButtonDisabled = false
                            self.moveToNextQuiz()
                            self.isTimeOver = false
                        }
                    }
                )
                .padding(.horizontal, 182)
                
                // Question Text
                VStack {
                    if (selectedAnswer != nil || isTimeOver) {
                        Text(quizzes[currentQuizIndex].explanation)
                            .font(Font.custom("GmarketSansMedium", size: 30))
                            .foregroundColor(Color("myDarkBlue"))
                    }
                    
                    Text(quizzes[currentQuizIndex].question)
                        .font(Font.custom("GmarketSansBold", size: 40))
                        .foregroundColor(Color("myGrey01"))
                        .padding()
                }.frame(height: 260)
                
                Spacer()
                
                // Answer Buttons
                ChoiceCardButtonView(
                    selectedAnswer: $selectedAnswer,
                    labels: quizzes[currentQuizIndex].options,
                    correctAnswer: quizzes[currentQuizIndex].correctAnswer
                ) { selectedIndex in
                    self.selectedAnswer = selectedAnswer
                    progressBarManager.pause()
                    handleAnswerSelection(selectedIndex: selectedIndex)
                }
                .padding(.bottom, 86)
                .disabled(isButtonDisabled)
            }
            .padding()
            .navigationDestination(isPresented: $isGameFinished) {
                Text("게임이 끝났습니다! 맞춘 갯수: \(correctCount) / 총 문제: \(quizzes.count)")
                    .font(.title)
                    .padding()
            }
            .onAppear {
                progressBarManager.start() // 타이머 시작
            }
        }
        
        private func handleAnswerSelection(selectedIndex: Int) {
            if quizzes[currentQuizIndex].options[selectedIndex] == quizzes[currentQuizIndex].correctAnswer {
                correctCount += 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isButtonDisabled = true
                moveToNextQuiz()
            }
        }
        
        private func moveToNextQuiz() {
            if currentQuizIndex < quizzes.count - 1 {
                currentQuizIndex += 1
                selectedAnswer = nil
                isButtonDisabled = false
                progressBarManager.reset()
                progressBarManager.start()
            } else {
                isGameFinished = true
            }
        }
    }
}

#Preview {
    MultipleChoiceGameView()
}
