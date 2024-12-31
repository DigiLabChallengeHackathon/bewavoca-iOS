import SwiftUI
import Combine

struct TimeProgressBar: View {
    @ObservedObject var manager: TimeProgressBarManager
    let fillColor: Color
    let warningColor: Color
    let onComplete: (() -> Void)?
    
    let barWidth: CGFloat = 729
    let barHeight: CGFloat = 60
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: barHeight)
                .background(Color("myGrey07"))
                .cornerRadius(barHeight / 2)

            Rectangle()
                .foregroundColor(manager.isWarning ? warningColor : fillColor)
                .frame(width: barWidth * manager.progress, height: barHeight)
                .cornerRadius(barHeight / 2)
            HStack {
                Text("\(Int(manager.remainingTime)) 초")
                    .font(Font.custom("GmarkeSansMedium", size: 30))
                    .foregroundColor(Color("myGrey01"))
                    .padding(.leading, 25)
                Spacer()
            }
        }
        .frame(width: barWidth, height: barHeight)
        .onAppear {
            manager.onComplete = onComplete
        }
    }
}

// MARK: - Timer Manager
class TimeProgressBarManager: ObservableObject {
    @Published var progress: Double = 0.0
    @Published var isWarning: Bool = false

    private var timerCancellable: AnyCancellable?
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
        reset()
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.elapsedTime += 1
                self.remainingTime = max(self.duration - self.elapsedTime, 0)
                self.progress = self.elapsedTime / self.duration
                self.isWarning = self.remainingTime <= self.warningTime

                if self.remainingTime <= 0 {
                    self.stop()
                    self.onComplete?()
                }
            }
    }

    func pause() {
        timerCancellable?.cancel()
    }

    func reset() {
        timerCancellable?.cancel()
        elapsedTime = 0.0
        remainingTime = duration
        progress = 0.0
        isWarning = false
    }

    private func stop() {
        timerCancellable?.cancel()
        isWarning = false
    }
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
                onComplete: { print("타이머 종료") }
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