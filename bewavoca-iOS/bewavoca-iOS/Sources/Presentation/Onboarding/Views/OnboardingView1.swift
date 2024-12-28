import SwiftUI

struct OnboardingView1: View {
    @State private var isEyeOpened = false
    
    var body: some View {
        ZStack {
            Image(OnboardingPage.page1.backgroundImage)
                .resizable()
                .frame(width: DeviceConstant.baseWidth * 1.22,
                       height: DeviceConstant.baseHeight * 1.077)
            
            Image(OnboardingPage.page1.characterImage)
                .frame(width: 1025)
                .offset(x: 450, y: 130)
            
            // 눈 뜨는 애니메이션
            EyeOpeningAnimation(isOpened: isEyeOpened)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 3)) {
                isEyeOpened = true
            }
        }
    }
}

// MARK: - Eye Opening Animation View
private struct EyeOpeningAnimation: View {
    let isOpened: Bool
    
    var body: some View {
        ZStack {
            // 위쪽 검정색 뷰
            Color.black
                .frame(height: UIScreen.main.bounds.height)
                .frame(maxHeight: .infinity, alignment: .top)
                .offset(y: isOpened ? -UIScreen.main.bounds.height : 0)
            
            // 아래쪽 검정색 뷰
            Color.black
                .frame(height: UIScreen.main.bounds.height)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: isOpened ? UIScreen.main.bounds.height : 0)
        }
    }
}
