import SwiftUI

struct OnboardingView6: View {
    var body: some View {
        ZStack {
            Image(OnboardingPage.page6.backgroundImage)
                .resizable()
                .frame(width: DeviceConstant.baseWidth * 1.22,
                       height: DeviceConstant.baseHeight * 1.077)
            
            Image(OnboardingPage.page6.characterImage)
                .offset(x: -365, y: -100)
            
            if let textboxImage = OnboardingPage.page6.textboxImage {
                Image(textboxImage)
                    .offset(y: 350)
            }
            
        }
    }
}
