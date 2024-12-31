import SwiftUI

struct OnboardingView2: View {
    var body: some View {
        ZStack {
            Image(OnboardingPage.page2.backgroundImage)
                .resizable()
                .frame(width: DeviceConstant.baseWidth * 1.22,
                       height: DeviceConstant.baseHeight * 1.077)
            
            Image(OnboardingPage.page2.characterImage)
                .frame(width: 1025)
                .offset(x: 450, y: 130)
            
            if let textboxImage = OnboardingPage.page2.textboxImage {
                Image(textboxImage)
                    .frame(width: 1213)
                    .offset(y: 400)
            }
        }
    }
}
