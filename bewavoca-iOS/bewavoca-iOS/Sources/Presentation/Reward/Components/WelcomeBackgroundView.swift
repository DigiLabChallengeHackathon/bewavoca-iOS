import SwiftUI

struct WelcomeBackgroundView: View {
    var body: some View {
        Image("splash_welcome_background")
            .resizable()
            .frame(width: DeviceConstant.baseWidth * 1.22, height: DeviceConstant.baseHeight * 1.077)
    }
}
