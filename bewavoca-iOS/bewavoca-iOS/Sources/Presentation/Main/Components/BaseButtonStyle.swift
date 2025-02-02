import SwiftUI

/**
 버튼 터치 시 회색으로 변경되지 않게 작업
 버튼 터치 시 효과음 추가
 */
struct BaseButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.5 : 1.0) // 터치 시 약간의 투명도 변경
            .onChange(of: configuration.isPressed, initial: false) { _, newValue in
                if newValue {
                    HapticManager.shared.trigger(.tap)
                    SoundManager.shared.playEffect(.tap)
                }
            }
    }
}

// MARK: - 테스트용 뷰
struct TestButtonView: View {
    var body: some View {
        Button("Tap Effect") {
            print("tap!")
        }
        .buttonStyle(BaseButtonStyle())
        .padding()
    }
}

#Preview {
    TestButtonView()
}
