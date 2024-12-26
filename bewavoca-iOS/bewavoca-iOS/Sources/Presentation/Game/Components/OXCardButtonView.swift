import SwiftUI

// MARK: - Enum ButtonType
enum ButtonType: String {
    case O
    case X
}

// MARK: - OXCardButton (재사용 가능한 버튼 컴포넌트)
struct OXCardButton: View {
    var buttonType: ButtonType
    @Binding var selectedAnswer: ButtonType? // 선택된 답을 바인딩
    var onButtonClick: (ButtonType) -> Void // 버튼 클릭 시 처리할 클로저
    
    var body: some View {
        Button(action: {
            selectedAnswer = buttonType
            onButtonClick(buttonType) // 선택된 답 반환
        }) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 349, height: 151)
                .background(buttonColor(buttonType: buttonType)) // 버튼 색상
                .cornerRadius(48)
                .overlay(
                    Image("icon_card_\(buttonType.rawValue.lowercased())") // 버튼 아이콘
                        .scaledToFit()
                )
        }
    }
    
    private func buttonColor(buttonType: ButtonType) -> Color {
        // 선택된 답과 비교하여 색상 변경
        if let selectedAnswer = selectedAnswer {
            return buttonType == selectedAnswer ? Color("myDarkBlue") : Color("myGrey07")
        } else {
            // 선택되지 않았을 경우 기본 색상
            return buttonType == .O ? Color("myGreen") : Color("myRed")
        }
    }
}

// MARK: - OXCardButtonView
struct OXCardButtonView: View {
    @Binding var selectedAnswer: ButtonType? // 사용자가 선택한 답
    
    var correctAnswer: ButtonType // 문제의 정답
    var onButtonClick: (ButtonType) -> Void
    
    var body: some View {
        VStack {
            HStack {
                OXCardButton(buttonType: .O, selectedAnswer: $selectedAnswer, onButtonClick: onButtonClick)
                    .padding(.trailing, 31)
                
                OXCardButton(buttonType: .X, selectedAnswer: $selectedAnswer, onButtonClick: onButtonClick)
            }
        }
    }
}

// MARK: - OXCardButtonTestView
struct OXCardButtonTestView: View {
    @State private var selectedAnswer: ButtonType? = nil // 사용자가 선택했는지에 대한 여부
    
    var correctAnswer: ButtonType // 문제의 정답
    
    var body: some View {
        VStack {
            OXCardButtonView(selectedAnswer: $selectedAnswer, correctAnswer: correctAnswer) { selectedAnswer in
                self.selectedAnswer = selectedAnswer
            }
            .padding()
            
            Text(selectedAnswer == nil ? "문제의 답 : \(correctAnswer)" : (selectedAnswer == correctAnswer ? "맞았다" : "틀렸다"))
                .font(.title)
                .padding()

        }
    }
    
}

#Preview {
    OXCardButtonTestView(correctAnswer: .O)
}
