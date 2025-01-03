import SwiftUI

struct BackgroundMusicModifier: ViewModifier {
    let viewName: String
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                BackgroundMusicManager.shared.handleBackgroundMusic(for: viewName)
            }
            .onChange(of: viewName) { oldValue, newValue in
                BackgroundMusicManager.shared.handleBackgroundMusic(for: newValue)
            }
    }
}

extension View {
    func withBackgroundMusic(viewName: String) -> some View {
        modifier(BackgroundMusicModifier(viewName: viewName))
    }
}

struct MusicTestView: View {
    @State private var currentViewIndex = 0
    let viewNames = ["MainView", "CreateNickNameView", "OnboardingView", "OXGameView", "MultipleChoiceGameView"]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 현재 뷰에 해당하는 이름을 표시
                Text(viewNames[currentViewIndex])
                    .navigationTitle(viewNames[currentViewIndex])
                    .navigationBarTitleDisplayMode(.inline)

                Button("Go to Next View") {
                    // 화면을 전환할 때마다 currentViewIndex를 변경
                    currentViewIndex = (currentViewIndex + 1) % viewNames.count
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.1))
            .animation(.easeInOut, value: currentViewIndex)
        }
        .withBackgroundMusic(viewName: viewNames[currentViewIndex])
    }
}

#Preview {
    MusicTestView()
}
