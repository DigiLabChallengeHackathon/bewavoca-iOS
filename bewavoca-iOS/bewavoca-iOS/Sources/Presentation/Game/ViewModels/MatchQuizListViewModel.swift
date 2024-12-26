import Foundation

// MARK: - MatchQuiz Model
struct MatchQuiz: Identifiable {
    let matchId: Int
    let standard: String
    let jeju: String

    // Identifiable 프로토콜 준수
    var id: Int { matchId }
}

// MARK: - MatchQuizList Model
struct MatchQuizList {
    let status: String
    let message: String
    let data: MatchQuizData
}

struct MatchQuizData {
    let type: String
    let level: Int
    let quizzes: [MatchQuiz]
}

// MARK: - MatchQuizListViewModel
class MatchQuizListViewModel: ObservableObject {
    @Published var matchQuizList: MatchQuizList

    // 초기화
    init() {
        self.matchQuizList = MatchQuizListViewModel.mockData()
    }

    // Mock 데이터를 반환하는 함수
    static func mockData() -> MatchQuizList {
        let quizzes = [
            MatchQuiz(matchId: 1, standard: "할아버지", jeju: "하르방"),
            MatchQuiz(matchId: 2, standard: "무지개", jeju: "상고"),
            MatchQuiz(matchId: 3, standard: "고양이", jeju: "깅이"),
            MatchQuiz(matchId: 4, standard: "예쁘다", jeju: "곱다")
        ]

        let data = MatchQuizData(type: "match", level: 2, quizzes: quizzes)

        return MatchQuizList(
            status: "success",
            message: "Quiz retrieved successfully",
            data: data
        )
    }
}
