import SwiftUI

// MARK: - NicknameCardView
/// 닉네임 입력 카드 뷰
/// - 주요 구성 요소:
///   - 캐릭터 이미지
///   - 인삿말 및 안내 텍스트
///   - 닉네임 입력 텍스트 필드
///   - 입력 제한 안내 텍스트
struct NicknameCardView: View {
    let selectedCharacter: String // 실 개발시에는 Int형, default = 1로 해야 함. @Binding써야함
    let text: String // "이름을 알려줘" 부분. 그냥 넣어도 되는데 재사용을 대비하여 변수로 뒀습니다.
    
    @Binding var nickname: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 95)
                .fill(Color.white)
                .frame(width: 811, height: 463)
                .shadow(radius: 10)
            
            HStack(spacing: 10) {
                Image(selectedCharacter)
                    .frame(width: 344)
                    .cornerRadius(65)
                
                VStack(alignment: .center, spacing: 15) {
                    PromptTextView(text: text)
                    Spacer().frame(height: 5)
                    CustomTextField(text: $nickname, placeholder: "하르방")
                        .frame(width: 325)
                    InputLimitInfoView(infoText: "5자까지 입력할 수 있어요")
                }
                .padding(.leading, 30)
            }
        }
    }
}

// MARK: - PromptTextView
/// 인삿말 및 안내 텍스트를 표시하는 뷰
/// - 주요 구성:
///   - 상단 인삿말 텍스트
struct PromptTextView: View {
    let greeting: String = "혼저옵서!"
    let text: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Spacer().frame(height: 10)
            Text(greeting)
            Text(text)
        }
        .font(.custom("GmarketSansMedium", size: 50)) // iPad 12.9" 기준 크기
        .foregroundColor(Color("myDarkBlue"))
        .multilineTextAlignment(.center)
    }
}

// MARK: - CustomTextField
/// 닉네임 입력 텍스트 필드
/// - 특징:
///   - 최대 5자까지 입력 가능
///   - Placeholder 표시
///   - ios 버전에 따른 조건부 컴파일
struct CustomTextField: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    let placeholder: String
    
    var body: some View {
        TextField("", text: $text)
            #if os(iOS)
            #if compiler(>=5.9)
            .onChange(of: text) { oldValue, newValue in
                if newValue.count > 5 {
                    text = String(newValue.prefix(5))
                }
            }
            #else
            .onChange(of: text) { newValue in
                if newValue.count > 5 {
                    text = String(newValue.prefix(5))
                }
            }
            #endif
            #endif
            .font(.custom("GmarketSansBold", size: 50))
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .focused($isFocused)
            .placeholder(when: text.isEmpty && !isFocused) {
                Text(placeholder)
                    .font(.custom("GmarketSansBold", size: 50))
                    .foregroundColor(Color("myGrey05"))
                    .multilineTextAlignment(.center)
            }
            .frame(height: 125)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 22)
                    .fill(Color("myGrey07"))
            )
    }
}

// MARK: - InputLimitInfoView
/// 입력 제한 안내 텍스트를 표시하는 뷰
struct InputLimitInfoView: View {
    let infoText: String
    
    var body: some View {
        Text(infoText)
            .font(.custom("GmarketSansMedium", size: 25))
            .foregroundColor(Color("myDarkBlue"))
    }
}

// MARK: - Placeholder Extension
/// Placeholder 표시를 위한 View Extension
extension View {
    /// Placeholder를 추가하는 메서드
    /// - Parameters:
    ///   - shouldShow: Placeholder를 표시할 조건
    ///   - alignment: Placeholder의 정렬
    ///   - placeholder: Placeholder로 표시할 뷰
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .center,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

// MARK: - Preview
#Preview {
    NicknameCardView(
        selectedCharacter: "character_card_harbang",
        text: "이름을 알려줘!",
        nickname: .constant("테스트")
    )
}
