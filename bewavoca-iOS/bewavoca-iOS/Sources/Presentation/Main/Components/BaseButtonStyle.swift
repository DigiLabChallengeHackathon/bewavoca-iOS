import SwiftUI

/**
 버튼 터치 시 회색으로 변경 되지 않게 작업
 추후 Sound, Haptic 를 이용해 효과음/진동 추가 예정
 */
struct BaseButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(1.0)
    }
}
