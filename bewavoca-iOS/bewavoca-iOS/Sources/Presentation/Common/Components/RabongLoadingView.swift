import SwiftUI

struct RabongLoadingView: View {
    @State private var showFirstView = true
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            if showFirstView {
                ShakeLeafAnimationView()
                    .transition(.scale)
            } else {
                JumpRabongAnimationView()
                    .transition(.scale)
            }
        }
        .onAppear {
            startLoadingTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func startLoadingTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            withAnimation {
                showFirstView.toggle()
            }
        }
    }
}

struct JumpRabongAnimationView: View {
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        VStack {
            Image("image_loading_full_leaf")
                .resizable()
                .scaledToFit()
                .frame(width: 170, height: 168)
                .offset(y: offsetY)
                .onAppear {
                    startBouncingAnimation()
                }
        }
    }
    
    private func startBouncingAnimation() {
        withAnimation(
            Animation.interpolatingSpring(mass: 5, stiffness: 200, damping: 5, initialVelocity: 0)
                .repeatCount(2, autoreverses: true)
        ) {
            offsetY = -40
        }
    }
}

struct ShakeLeafAnimationView: View {
    @State private var angle: Double = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Image("image_loading_leaf")
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 30)
                .rotationEffect(Angle(degrees: angle), anchor: .bottom)
                .onAppear {
                    startShakingAnimation()
                }
            
            Image("image_loading_no_leaf")
                .resizable()
                .scaledToFit()
                .frame(width: 121, height: 138)
        }
    }
    
    private func startShakingAnimation() {
        withAnimation(
            Animation.easeOut(duration: angle == -10 ? 0.4 : 0.8)
        ) {
            angle = angle == -10 ? 55 : -10
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (angle == -10 ? 0.4 : 0.8)) {
            startShakingAnimation()
        }
    }
}

#Preview {
    RabongLoadingView()
}
