import SwiftUI

struct OnboardingView5: View {
    var body: some View {
        ZStack {
            Image(OnboardingPage.page5.backgroundImage)
                .resizable()
                .frame(width: DeviceConstant.baseWidth * 1.22,
                       height: DeviceConstant.baseHeight * 1.077)
            
            Image(OnboardingPage.page5.characterImage)
                .offset(y: -120)
            
            if let textboxImage = OnboardingPage.page5.textboxImage {
                Image(textboxImage)
                    .offset(y: 350)
            }
            
        }
    }
}
