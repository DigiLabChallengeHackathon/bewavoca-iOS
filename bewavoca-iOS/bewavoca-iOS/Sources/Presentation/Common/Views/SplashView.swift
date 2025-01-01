import SwiftUI

struct SplashView: View {
    var body: some View {
        DeviceScaledView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                Image("splash_image")
                    .frame(width: DeviceConstant.baseWidth * 1.22,
                           height: DeviceConstant.baseHeight * 1.077)
            }
        }
    }
}
