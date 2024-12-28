// MARK: - Page Type
enum OnboardingPage: Int, CaseIterable {
    case page1, page2, page3, page4, page5, page6, page7
    
    var backgroundImage: String {
        switch self {
        case .page1, .page2:
            return "onboarding_background_1"
        case .page3, .page6:
            return "onboarding_background_2"
        case .page4, .page5:
            return "onboarding_background_3"
        case .page7:
            return "onboarding_background_last"
        }
    }
    
    var characterImage: String {
        switch self {
        case .page1, .page2:
            return "onboarding_harbang_1"
        case .page3, .page6:
            return "onboarding_harbang_2"
        case .page4:
            return "onboarding_colorMap"
        case .page5:
            return "onboarding_grayMap"
        case .page7:
            return "onboarding_harbang_last"
        }
    }
    
    var textboxImage: String? {
        switch self {
        case .page1:
            return nil
        case .page2:
            return "onboarding_textbox_1"
        case .page3:
            return "onboarding_textbox_2"
        case .page4:
            return "onboarding_textbox_3"
        case .page5:
            return "onboarding_textbox_3"
        case .page6:
            return "onboarding_textbox_4"
        case .page7:
            return "onboarding_textbox_5"
        }
    }
}
