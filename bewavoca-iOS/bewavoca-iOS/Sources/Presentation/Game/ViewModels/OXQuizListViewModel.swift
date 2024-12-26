import Foundation

// MARK: - OXQuiz Model
struct OXQuiz: Identifiable {
    let oxId: Int
    let question: String
    let correctAnswer: Bool
    let explanation: String
    let voice: String?
    
    // Identifiable 프로토콜 준수
    var id: Int { oxId }
}

// MARK: - OXQuizList Model
struct OXQuizList {
    let status: String
    let message: String
    let data: OXQuizData
}

struct OXQuizData {
    let type: String
    let level: Int
    let quizzes: [OXQuiz]
}

// MARK: - OXQuizListViewModel
class OXQuizListViewModel: ObservableObject {
    @Published var oxQuizList: OXQuizList
    
    // 초기화
    init() {
        self.oxQuizList = OXQuizListViewModel.mockData()
    }
    
    // Mock 데이터를 반환하는 함수
    static func mockData() -> OXQuizList {
        let quizzes = [
            OXQuiz(oxId: 8, question: "[바나나]는 제주어로 바나나다", correctAnswer: true, explanation: "바나나는 제주어로 A입니다.", voice: nil),
            OXQuiz(oxId: 9, question: "[딸기]는 제주어로 딸기가 아니다", correctAnswer: false, explanation: "딸기는 제주어로 B가 아닙니다.", voice: nil),
            OXQuiz(oxId: 10, question: "[한라봉]은 제주도의 대표 과일이다", correctAnswer: true, explanation: "한라봉은 제주도의 대표 과일로 유명합니다.", voice: nil)
        ]
        
        let data = OXQuizData(type: "ox", level: 1, quizzes: quizzes)
        
        return OXQuizList(status: "success", message: "Quiz retrieved successfully", data: data)
    }
}
