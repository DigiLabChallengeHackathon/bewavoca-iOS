import SwiftUI

struct OnboardingView1: View {
    var body: some View {
        ZStack {
            Image(OnboardingPage.page1.backgroundImage)
                .resizable()
                .frame(width: DeviceConstant.baseWidth * 1.22,
                       height: DeviceConstant.baseHeight * 1.077)
            
            Image(OnboardingPage.page1.characterImage)
                .frame(width: 1025)
                .offset(x: 450, y: 130)
        }
    }
}
