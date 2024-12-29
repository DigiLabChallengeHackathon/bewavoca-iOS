import AVKit
import SwiftUI

// MARK: - SoundType Enum
enum SoundType: String {
    case tap
    case correct
    case incorrect
    case timer
    case select
}

// MARK: - SoundManager
final class SoundManager {
    static let shared = SoundManager()
    private init() {}

    private var effectPlayers = NSCache<NSString, AVAudioPlayer>() // 효과음 플레이어 캐시
    private var keys = Set<NSString>() // 캐시된 키 관리

    // MARK: - Sound Effect Management
    func playEffect(_ soundType: SoundType) {
        let key = NSString(string: soundType.rawValue)

        if let cachedPlayer = effectPlayers.object(forKey: key) {
            restartPlayer(cachedPlayer)
        } else {
            createAndPlayEffectPlayer(for: soundType, key: key)
        }
    }

    // MARK: - Sound Effect Continuous Management
    func playEffectContinuously(_ soundType: SoundType) {
        let key = NSString(string: soundType.rawValue)

        if let cachedPlayer = effectPlayers.object(forKey: key) {
            cachedPlayer.numberOfLoops = -1 // 무한 반복
            cachedPlayer.play()
        } else {
            guard let url = Bundle.main.url(forResource: soundType.rawValue, withExtension: "mp3") else {
                print("SoundManager - playEffectContinuously / Sound file for \(soundType.rawValue) not found in bundle.")
                return
            }

            do {
                let audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer.numberOfLoops = -1 // 무한 반복
                audioPlayer.prepareToPlay()
                effectPlayers.setObject(audioPlayer, forKey: key)
                keys.insert(key)
                audioPlayer.play()
            } catch {
                print("SoundManager - playEffectContinuously / Failed to create audio player for \(soundType.rawValue): \(error.localizedDescription)")
            }
        }
    }

    func stopEffect(_ soundType: SoundType) {
        let key = NSString(string: soundType.rawValue)
        effectPlayers.object(forKey: key)?.stop()
    }

    func stopAllEffects() {
        for key in keys {
            effectPlayers.object(forKey: key)?.stop()
        }
    }

    // MARK: - Private Helpers
    private func restartPlayer(_ player: AVAudioPlayer) {
        player.stop()
        player.currentTime = 0
        player.play()
    }

    private func createAndPlayEffectPlayer(for soundType: SoundType, key: NSString) {
        guard let url = Bundle.main.url(forResource: soundType.rawValue, withExtension: "mp3") else {
            print("SoundManager - createAndPlayEffectPlayer / Sound file for \(soundType.rawValue) not found in bundle.")
            return
        }

        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            effectPlayers.setObject(audioPlayer, forKey: key)
            keys.insert(key) // 키를 Set에 추가
            audioPlayer.play()
        } catch {
            print("SoundManager - createAndPlayEffectPlayer Failed to create audio player for \(soundType.rawValue): \(error.localizedDescription)")
        }
    }
}

// MARK: - Test View
struct SoundTestView: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Play Tap Sound") {
                SoundManager.shared.playEffect(.tap)
            }

            Button("Play Correct Sound") {
                SoundManager.shared.playEffect(.correct)
            }

            Button("Play Incorrect Sound") {
                SoundManager.shared.playEffect(.incorrect)
            }

            Button("Play Timer Sound") {
                SoundManager.shared.playEffectContinuously(.timer)
            }

            Button("Play Select Sound") {
                SoundManager.shared.playEffect(.select)
            }

            Button("Stop All Effects") {
                SoundManager.shared.stopAllEffects()
            }
        }
        .padding()
    }
}

// MARK: - Preview
struct SoundTestView_Previews: PreviewProvider {
    static var previews: some View {
        SoundTestView()
    }
}
