import SwiftUI

/**
 기본 백그라운드 컬러 적용
 */
struct ColorBackgroundView: View {
    var body: some View {
        Color("myDarkBlue")
            .ignoresSafeArea()
    }
}

#Preview {
    ColorBackgroundView()
}
