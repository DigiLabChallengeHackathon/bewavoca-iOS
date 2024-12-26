import SwiftUI

// MARK: - ChoiceCardButton (재사용 가능한 버튼 컴포넌트)
struct ChoiceCardButton: View {
    var id: Int // 버튼을 식별하기 위한 ID (배열 인덱스)
    var label: String // 버튼에 표시될 텍스트
    @Binding var selectedAnswer: Int? // 선택된 답을 바인딩
    var correctAnswer: Int // 문제의 정답 (배열 인덱스)
    var onButtonClick: (Int) -> Void // 버튼 클릭 시 처리할 클로저

    var body: some View {
        Button(action: {
            selectedAnswer = id
            onButtonClick(id) // 선택된 답 반환
        }) {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 349, height: 96)
                    .background(buttonColor(id: id))
                    .cornerRadius(48)
                Text(label)
                    .font(Font.custom("GmarketSansBold", size: 40))
                    .foregroundColor(textColor(id: id))
            }
            .frame(width: 349, height: 96)
        }
    }

    private func buttonColor(id: Int) -> Color {
        if let selectedAnswer = selectedAnswer {
            if selectedAnswer == id {
                return selectedAnswer == correctAnswer ? Color("myGreen") : Color("myDarkBlue")
            } else if id == correctAnswer {
                return Color("myRed")
            } else {
                return Color("myGrey08")
            }
        } else {
            return Color("myGrey08")
        }
    }

    private func textColor(id: Int) -> Color {
        if let selectedAnswer = selectedAnswer {
            if selectedAnswer == id {
                return selectedAnswer == correctAnswer ? .black : .white
            } else if id == correctAnswer {
                return .black
            } else {
                return .black
            }
        } else {
            return .black
        }
    }
}

// MARK: - ChoiceCardButtonView
struct ChoiceCardButtonView: View {
    @Binding var selectedAnswer: Int? // 선택한 답
    var labels: [String]
    var correctAnswer: String
    var onButtonClick: (Int) -> Void

    var body: some View {
        VStack(spacing: 22) {
            ForEach(0..<2, id: \.self) { row in
                HStack(spacing: 31) {
                    ForEach(0..<2, id: \.self) { col in
                        let index = row * 2 + col
                        if index < labels.count {
                            ChoiceCardButton(
                                id: index,
                                label: labels[index],
                                selectedAnswer: $selectedAnswer,
                                correctAnswer: labels.firstIndex(of: correctAnswer) ?? -1,
                                onButtonClick: onButtonClick
                            )
                        }
                    }
                }
            }
        }

    }
}

// MARK: - ChoiceCardButtonTestView
struct ChoiceCardButtonTestView: View {
    @State private var selectedAnswer: Int? = nil // 선택한 답

    var labels: [String]
    var correctAnswer: String

    var body: some View {
        VStack {
            ChoiceCardButtonView(selectedAnswer: $selectedAnswer, labels: labels, correctAnswer: correctAnswer) { selectedAnswer in
                self.selectedAnswer = selectedAnswer
            }
            .padding()

            Text(selectedAnswer == nil ? "문제의 답 : \(correctAnswer)" : (selectedAnswer == labels.firstIndex(of: correctAnswer) ? "맞았다" : "틀렸다"))
                .font(.title)
                .padding()
        }
    }
}

#Preview {
    ChoiceCardButtonTestView(labels: ["레몬", "복숭아", "사과", "키위"], correctAnswer: "복숭아")
}
