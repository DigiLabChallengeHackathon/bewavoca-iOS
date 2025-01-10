import UIKit

final class HapticManager {
    static let shared = HapticManager()
    private init() {}

    private var impactGenerators: [UIImpactFeedbackGenerator.FeedbackStyle: UIImpactFeedbackGenerator] = [:]
    private let selectionGenerator = UISelectionFeedbackGenerator()

    func trigger(_ type: HapticType) {
        switch type {
        case .impact(let impactType):
            triggerImpact(for: impactType)
        case .selection:
            triggerSelection()
        case .tap:
            triggerTap()
        case .none:
            break
        }
    }

    private func triggerImpact(for type: ImpactType) {
        guard let style = mapImpactStyle(for: type) else { return }
        let generator = getImpactGenerator(for: style)
        generator.impactOccurred()
    }

    private func triggerSelection() {
        selectionGenerator.selectionChanged()
    }

    private func triggerTap() {
        let generator = UIImpactFeedbackGenerator(style: .rigid)
        generator.impactOccurred(intensity: 0.4)
    }

    private func mapImpactStyle(for type: ImpactType) -> UIImpactFeedbackGenerator.FeedbackStyle? {
        switch type {
        case .light: return .light
        case .medium: return .medium
        case .heavy: return .heavy
        case .soft: return .soft
        case .rigid: return .rigid
        }
    }

    private func getImpactGenerator(for style: UIImpactFeedbackGenerator.FeedbackStyle) -> UIImpactFeedbackGenerator {
        if let cached = impactGenerators[style] {
            return cached
        }

        let generator = UIImpactFeedbackGenerator(style: style)
        impactGenerators[style] = generator
        return generator
    }
}
