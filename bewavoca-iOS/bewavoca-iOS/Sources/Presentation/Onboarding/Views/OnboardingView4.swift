import SwiftUI

struct OnboardingView4: View {
    var body: some View {
        ZStack {
            Image(OnboardingPage.page4.backgroundImage)
                .resizable()
                .frame(width: DeviceConstant.baseWidth * 1.22,
                       height: DeviceConstant.baseHeight * 1.077)
            
            Image(OnboardingPage.page4.characterImage)
                .offset(y: -120)

            if let textboxImage = OnboardingPage.page4.textboxImage {
                Image(textboxImage)
                    .offset(y: 350)
            }
            
        }
    }
}
