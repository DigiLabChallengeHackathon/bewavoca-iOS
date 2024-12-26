import SwiftUI

struct OXGameView: View {
    var body: some View {
        DeviceScaledView {
            BackgroundRectangleView {
                    NavigationStack{
                        
                        VStack {
                            // topview
                            OXGameTopView()
                            
                            OXGameBodyView()
                            
                            Spacer()
                        }
                        .background(Color.clear)
                        .padding(.top, 54)
                }
                
            }
        }
    }
}

struct OXGameTopView: View {
    var body: some View {
        HStack {
            // 1. NavigationLink (왼쪽 정렬)
            NavigationLink(destination: NextSampleGameView(test: "뒤로 가는 페이지")) {
                Image("btn_back")
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            VStack{
                Text("제주어 OX 퀴즈")
                    .font(Font.custom("GmarketSansBold", size: 53))
                    .foregroundColor(Color("myGrey01"))
                    .padding(.bottom, 21)
                
                Text("제시된 문장을 보고, 올바른 내용이면 O, 틀린 내용이면 X를 고르세요!")
                    .font(Font.custom("Gmarket Sans", size: 20))
                    .foregroundColor(Color(red: 0.29, green: 0.30, blue: 0.33))
            }
            
            Spacer()
            
            // 3. ImageButton (우측 정렬)
            Button(action: {
                print("Button clicked")
            }) {
                Image("btn_sound")
                    .foregroundColor(.blue)
                    .padding(.trailing, 16)
            }
            //            .hidden()
        }
        .padding(.top, 50)
        .padding(.horizontal, 50)
        .frame(height: 156)
    }
}


struct OXGameBodyView: View {
    @State private var currentQuizIndex: Int = 0
    @State private var correctCount: Int = 0 // 맞춘 갯수 바인딩(API로 보낼 예정)
    
    @State private var selectedAnswer: ButtonType? = nil
    @State private var isTimeOver: Bool = false
    
    @StateObject private var viewModel = OXQuizListViewModel()
    
    @StateObject private var progressBarManager = TimeProgressBarManager(duration: 15, warningTime: 5)
    
    @State private var shuffledQuizzes: [OXQuiz] = [
        OXQuiz(oxId: 8, question: "[바나나]는 제주어로 바나나다", correctAnswer: true, explanation: "바나나는 제주어로 A입니다.", voice: nil),
        OXQuiz(oxId: 9, question: "[딸기]는 제주어로 딸기가 아니다", correctAnswer: false, explanation: "딸기는 제주어로 B가 아닙니다.", voice: nil),
        OXQuiz(oxId: 10, question: "[한라봉]은 제주도의 대표 과일이다", correctAnswer: true, explanation: "한라봉은 제주도의 대표 과일로 유명합니다.", voice: nil)
    ]
    
    @State private var isOXGameFinished = false // 게임완료 여부
    @State private var isButtonDisabled = false // 버튼비활성화 여부
    
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
                if selectedAnswer == nil && !isTimeOver {
                    Text(shuffledQuizzes[currentQuizIndex].question)
                        .font(Font.custom("GmarketSansMedium", size: 40))
                        .foregroundColor(Color("myGrey01"))
                } else {
                    Text((selectedAnswer != nil) == shuffledQuizzes[currentQuizIndex].correctAnswer ? "정답이에요" : "오답이에요")
                        .font(Font.custom("GmarketSansMedium", size: 40))
                        .foregroundColor(shuffledQuizzes[currentQuizIndex].correctAnswer ? Color("myGreen") : Color("myRed"))
                        .padding(.bottom, 12)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 708, height: 120)
                            .foregroundColor(Color("myGrey08"))
                            .cornerRadius(36)
                        
                        Text("\(shuffledQuizzes[currentQuizIndex].explanation)")
                            .font(Font.custom("GmarketSansMedium", size: 30))
                            .foregroundColor(Color("myGrey01"))
                            .padding(.horizontal, 20)
                    }
                }
            }.frame(height: 260)
            
            Spacer()
            
            OXCardButtonView(selectedAnswer: $selectedAnswer, correctAnswer: shuffledQuizzes[currentQuizIndex].correctAnswer ? .O : .X) { selectedAnswer in
                self.selectedAnswer = selectedAnswer
                self.isTimeOver = true
                self.isButtonDisabled = true
                progressBarManager.pause()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isButtonDisabled = false
                    self.moveToNextQuiz()
                    self.isTimeOver = false
                }
            }
            .padding(.bottom, 132)
            .disabled(isButtonDisabled)
            .navigationDestination(isPresented: $isOXGameFinished) {
                NextSampleGameView(test: "맞춘갯수 \(correctCount)/총문제 \(shuffledQuizzes.count)")
            }
            
        }
        .frame(alignment: .top)
        .padding(.top, 54)
        .onAppear() {
            viewModel.oxQuizList = OXQuizListViewModel.mockData()
            //            shuffledQuizzes = viewModel.oxQuizList.data.quizzes.shuffled()
            progressBarManager.start()
        }
    }
    
    private func moveToNextQuiz() {
        if selectedAnswer != nil {
            if selectedAnswer == (shuffledQuizzes[currentQuizIndex].correctAnswer ? .O : .X) {
                correctCount += 1
            }
        }
        
        if currentQuizIndex < shuffledQuizzes.count - 1 {
            currentQuizIndex += 1
            selectedAnswer = nil
            progressBarManager.reset()
            progressBarManager.start()
        } else {
            isOXGameFinished = true
        }
    }
}

#Preview {
    OXGameView()
}

