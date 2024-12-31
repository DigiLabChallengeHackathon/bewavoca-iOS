import SwiftUI
import Combine

struct TimeProgressBar: View {
    @ObservedObject var manager: TimeProgressBarManager
    let fillColor: Color
    let warningColor: Color
    let onComplete: (() -> Void)?

    @State private var animateWarning: Bool = false

    var body: some View {
        VStack(spacing: 8) {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 60)
                        .background(Color("myGrey07"))
                        .cornerRadius(30)

                    Rectangle()
                        .foregroundColor(manager.isWarning ? (animateWarning ? warningColor : warningColor) : fillColor)
                        .frame(
                            width: max(geometry.size.width * manager.progress, 0),
                            height: geometry.size.height
                        )
                        .cornerRadius(30)
                        .clipped()
                    
                    HStack {
                        VStack(alignment: .trailing) {
                            Text("\(Int(manager.remainingTime)) 초")
                                .font(Font.custom("GmarkeSansMedium", size: 20))
                                .foregroundColor(Color("myGrey01"))
                        }
                        Spacer()
                    }.padding(25)
                }
                .onAppear {
                    if manager.isWarning {
                        animateWarning = true
                    }
                }
                .onReceive(manager.$isWarning) { warning in
                    withAnimation {
                        animateWarning = warning
                    }
                }
            }
            .frame(height: 60)
        }
        .onAppear {
            manager.onComplete = onComplete
        }
    }
}


// MARK: - Timer Manager
class TimeProgressBarManager: ObservableObject {
    @Published var progress: Double = 0.0
    @Published var isWarning: Bool = false

    private var timer: Timer?
    let duration: Double
    let warningTime: Double

    @Published private(set) var elapsedTime: Double = 0.0
    @Published private(set) var remainingTime: Double = 0.0

    var onComplete: (() -> Void)?

    init(duration: Double, warningTime: Double) {
        self.duration = duration
        self.warningTime = warningTime
        self.remainingTime = duration
    }

    func start() {
        guard timer == nil else { return }
        if remainingTime <= 0 {
            reset()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.elapsedTime += 1
            self.remainingTime = max(self.duration - self.elapsedTime, 0)
            self.progress = self.elapsedTime / self.duration
            self.isWarning = self.remainingTime <= self.warningTime
            if self.remainingTime <= 0 {
                self.timer?.invalidate()
                self.timer = nil
                self.onComplete?()
            }
        }
    }

    func pause() {
        timer?.invalidate()
        timer = nil
    }

    func reset() {
        timer?.invalidate()
        timer = nil
        elapsedTime = 0.0
        remainingTime = duration
        progress = 0.0
        isWarning = false
    }
}

// MARK: - Helper Function
func formatTime(_ time: Double) -> String {
    let minutes = Int(time) / 60
    let seconds = Int(time) % 60
    return String(format: "%02d:%02d", minutes, seconds)
}

// MARK: - Example Usage
struct TimeProgressBarView: View {
    @StateObject private var progressBarManager = TimeProgressBarManager(duration: 15, warningTime: 5)

    var body: some View {
        VStack(spacing: 20) {
            TimeProgressBar(
                manager: progressBarManager,
                fillColor: Color("myYellow"),
                warningColor: Color("myRed"),
                onComplete: {print("타이머 종료")}
            )

            HStack {
                Button("시작") {
                    progressBarManager.start()
                }
                Button("일시정지") {
                    progressBarManager.pause()
                }
                Button("초기화") {
                    progressBarManager.reset()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    TimeProgressBarView()
}
