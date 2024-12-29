import SwiftUI

struct OnboardingView7: View {
    var body: some View {
        ZStack {
            Image(OnboardingPage.page7.backgroundImage)
                .resizable()
                .frame(width: DeviceConstant.baseWidth * 1.22,
                       height: DeviceConstant.baseHeight * 1.077)
            
            Image(OnboardingPage.page7.characterImage)
                .offset(y: -50)

            if let textboxImage = OnboardingPage.page7.textboxImage {
                Image(textboxImage)
                    .offset(y: 350)
            }
            
        }
    }
}
