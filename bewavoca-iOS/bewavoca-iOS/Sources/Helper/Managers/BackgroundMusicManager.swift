import AVFoundation

final class BackgroundMusicManager {
    static let shared = BackgroundMusicManager()
    private init() {}

    private var currentMusic: BackgroundMusic?
    private var audioPlayer: AVAudioPlayer?

    // 뷰 이름에 맞는 음악을 처리하는 함수
    func handleBackgroundMusic(for viewName: String) {
        let musicType: BackgroundMusic

        // 각 뷰에 맞는 음악을 설정
        switch viewName {
        case "OnboardingView", "CreateNicknameView":
            musicType = .story
        case "MainView", "StageView", "CharacterSelectionView":
            musicType = .main
        case "OXGameView", "MultipleChoiceGameView", "MatchingGameView":
            musicType = .quiz
        default:
            return // 기본적으로 아무 것도 하지 않음
        }

        // 현재 음악과 비교하여 같은 음악일 경우, 음악을 멈추지 않고 계속 재생
        if currentMusic == musicType {
            return
        }

        // 음악이 다를 경우 기존 음악을 멈추고 새 음악을 재생
        playBackgroundMusic(musicType)
    }

    // 음악을 재생하는 함수
    private func playBackgroundMusic(_ musicType: BackgroundMusic) {
        // 음악 파일 경로를 확인하여 해당 음악을 재생
        guard let url = Bundle.main.url(forResource: musicType.rawValue, withExtension: "mp3") else {
            print("BackgroundMusicManager - Music file not found.")
            return
        }

        // 현재 음악이 다를 경우 기존 음악을 멈추고 새 음악을 재생
        stopBackgroundMusic()

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // 무한 반복
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            currentMusic = musicType  // 현재 음악을 업데이트
        } catch {
            print("BackgroundMusicManager - Failed to play music: \(error.localizedDescription)")
        }
    }

    // 음악을 멈추는 함수
    func stopBackgroundMusic() {
        audioPlayer?.stop()
        audioPlayer = nil
        currentMusic = nil  // 음악을 멈추고, currentMusic을 초기화
    }

    // 음악을 재시작하는 함수
    func restartBackgroundMusic() {
        if let currentMusic = currentMusic {
            playBackgroundMusic(currentMusic)
        }
    }
}
