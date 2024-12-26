import SwiftUI

/**
 버튼 터치 감지 시 사이즈 커졌다 작아지게 작업
 버튼 터치 시 회색으로 변경 되지 않게 작업
 추후 Sound, Haptic 를 이용해 효과음/진동 추가 예정
 */
struct EffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            .opacity(1.0)
    }
}
