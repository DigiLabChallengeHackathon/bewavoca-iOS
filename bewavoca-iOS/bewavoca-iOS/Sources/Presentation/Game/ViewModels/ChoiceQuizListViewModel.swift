import Foundation

// MARK: - ChoiceQuiz Model
struct ChoiceQuiz: Identifiable {
    let choiceId: Int
    let question: String
    let options: [String]
    let correctAnswer: String
    let explanation: String
    let voice: String?

    // Identifiable 프로토콜 준수
    var id: Int { choiceId }
}

// MARK: - ChoiceQuizList Model
struct ChoiceQuizList {
    let status: String
    let message: String
    let data: ChoiceQuizData
}

struct ChoiceQuizData {
    let type: String
    let level: Int
    let quizzes: [ChoiceQuiz]
}

// MARK: - ChoiceQuizListViewModel
class ChoiceQuizListViewModel: ObservableObject {
    @Published var choiceQuizList: ChoiceQuizList

    // 초기화
    init() {
        self.choiceQuizList = ChoiceQuizListViewModel.mockData()
    }

    // Mock 데이터를 반환하는 함수
    static func mockData() -> ChoiceQuizList {
        let quizzes = [
            ChoiceQuiz(
                choiceId: 15,
                question: "노란색이고 달콤한 과일은?",
                options: ["바나나", "사과", "키위", "포도"],
                correctAnswer: "바나나",
                explanation: "노란색이고 달콤한 과일은 바나나입니다.",
                voice: nil
            ),
            ChoiceQuiz(
                choiceId: 16,
                question: "빨간색 껍질을 가진 과일은?",
                options: ["딸기", "사과", "복숭아", "배"],
                correctAnswer: "사과",
                explanation: "빨간색 껍질을 가진 과일은 사과입니다.",
                voice: nil
            ),
            ChoiceQuiz(
                choiceId: 17,
                question: "신 맛이 강한 노란 과일은?",
                options: ["레몬", "바나나", "포도", "복숭아"],
                correctAnswer: "레몬",
                explanation: "신 맛이 강한 노란 과일은 레몬입니다.",
                voice: nil
            )
        ]

        let data = ChoiceQuizData(type: "choice", level: 3, quizzes: quizzes)

        return ChoiceQuizList(status: "success", message: "Quiz retrieved successfully", data: data)
    }
}
