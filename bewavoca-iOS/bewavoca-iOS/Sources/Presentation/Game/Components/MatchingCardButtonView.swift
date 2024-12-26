import SwiftUI

// MARK: - MatchingCardButton
struct MatchingCardButton: View {
    var label: String
    var state: CardState
    var action: () -> Void
    
    @State private var isFlashing = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 185, height: 185)
                .background(cardBackgroundColor)
                .cornerRadius(40)
                .opacity(isFlashing ? 0.6 : 1.0) // 깜빡이는 효과
                .animation(isFlashing ? Animation.linear(duration: 0.3).repeatForever(autoreverses: true) : .default, value: isFlashing)
            
            Text(label)
                .font(Font.custom("GmarketSansBold", size: 30))
                .foregroundColor(cardTextColor)
        }
        .onTapGesture {
            action()
        }
        .onChange(of: state, { oldValue, newValue in
            if newValue == .incorrect {
                isFlashing = true
            } else {
                isFlashing = false
            }
        })
    }
    
    private var cardBackgroundColor: Color {
        switch state {
        case .correct:
            return Color("myGreen")
        case .incorrect:
            return Color("myRed")
        case .selected:
            return Color("myDarkBlue")
        default:
            return Color("myGrey08")
        }
    }
    
    private var cardTextColor: Color {
        switch state {
        case .selected:
            return Color.white
        default:
            return Color.black
        }
    }
}

// MARK: - MatchingCardButtonView
struct MatchingCardButtonView: View {
    var quizzes: [MatchQuiz]
    @Binding var gameOver: Bool
    @Binding var matchedPairs: Int
    @Binding var currentMatchState: CardState
    
    @State private var cards: [MatchCard] = []
    @State private var selectedIndices: [Int] = []
    
    private let columns: [GridItem] = Array(repeating: GridItem(.fixed(185), spacing: 24), count: 4)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 24) {
            ForEach(cards.indices, id: \ .self) { index in
                MatchingCardButton(
                    label: cards[index].text,
                    state: cards[index].state
                ) {
                    handleCardTap(at: index)
                }
                .frame(height: 185)
            }
        }
        .onAppear {
            setupCards()
        }
    }
    
    private func setupCards() {
        var pairs: [MatchCard] = []
        for (_, quiz) in quizzes.enumerated() {
            let card1 = MatchCard(id: quiz.matchId, text: quiz.standard)
            let card2 = MatchCard(id: quiz.matchId, text: quiz.jeju)
            pairs.append(contentsOf: [card1, card2])
        }
        cards = pairs.shuffled()
    }
    
    private func handleCardTap(at index: Int) {
        guard cards[index].state == .defaultState else { return }
        
        cards[index].state = .selected
        selectedIndices.append(index)
        
        if selectedIndices.count == 2 {
            checkMatch()
        }
    }
    
    private func checkMatch() {
        let firstIndex = selectedIndices[0]
        let secondIndex = selectedIndices[1]
        
        if cards[firstIndex].id == cards[secondIndex].id {
            cards[firstIndex].state = .correct
            cards[secondIndex].state = .correct
            currentMatchState = .correct
            matchedPairs += 1
        } else {
            cards[firstIndex].state = .incorrect
            cards[secondIndex].state = .incorrect
            currentMatchState = .incorrect
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.cards[firstIndex].state = .defaultState
                self.cards[secondIndex].state = .defaultState
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            currentMatchState = .defaultState
        }
        
        selectedIndices.removeAll()
        
        checkGameOver()
    }
    
    private func checkGameOver() {
        if cards.allSatisfy({ $0.state == .correct }) {
            gameOver = true
        }
    }
}

// MARK: - Card State and Models
enum CardState {
    case defaultState  // 기본
    case selected      // 선택
    case correct       // 정답
    case incorrect     // 오답
}

struct MatchCard: Identifiable {
    let id: Int
    let text: String
    var state: CardState = .defaultState
}

// MARK: - Preview
#Preview {
    @Previewable @State var gameOver: Bool = false
    @Previewable @State var matchedPairs: Int = 0
    @Previewable @State var currentMatchState: CardState = .defaultState
    
    VStack {
        Text("Matched Pairs: \(matchedPairs)")
            .font(.title)
            .padding()
        
        if gameOver {
            Text("game over")
                .font(.largeTitle)
                .foregroundColor(.red)
        }
        
        MatchingCardButtonView(
            quizzes: [
                MatchQuiz(matchId: 1, standard: "할아버지", jeju: "하르방"),
                MatchQuiz(matchId: 2, standard: "무지개", jeju: "상고"),
                MatchQuiz(matchId: 3, standard: "고양이", jeju: "깅이"),
                MatchQuiz(matchId: 4, standard: "예쁘다", jeju: "곱다")
            ],
            gameOver: $gameOver,
            matchedPairs: $matchedPairs,
            currentMatchState: $currentMatchState
        )
    }
    .padding()
}
