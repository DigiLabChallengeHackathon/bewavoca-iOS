//
//  NicknameCardView.swift
//  bewavoca-iOS
//
//  Created by Muchan Kim on 12/11/24.
//
//  반응형 레이아웃 관련하여, 텍스트 필드나 프레임은 적용하였으나
//  일부 리소스는 못 구현한 상태입니다.
// 12.9inch, 13inch는 괜찮으나, 11인치 모델에서 각 컴포넌트의 크기가 맞지 않아 깨지는 현상이 있습니다.
//

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
                .shadow(radius: 5)
            
            HStack(spacing: 40) {
                Image(selectedCharacter)
                
                VStack(alignment: .center, spacing: 15) {
                    PromptTextView(text: text)
                    Spacer().frame(height: 5)
                    CustomTextField(text: $nickname, placeholder: "하르방")
                        .frame(
                            width: UIScreen.main.bounds.width * 0.225
                            // width: 305
                        )
                    InputLimitInfoView(infoText: "5자까지 입력할 수 있어요")
                }
            }
            .padding(20)
        }
        .frame(
            width: UIScreen.main.bounds.width * 0.585,
            height: UIScreen.main.bounds.height * 0.435
        )
        //          < 12.9inch size >
        //            width: 811,
        //            height: 463
    }
}

// MARK: - PromptTextView
/// 인삿말 및 안내 텍스트를 표시하는 뷰
/// - 주요 구성:
///   - 상단 인삿말 텍스트
///   - 하단 안내 텍스트
struct PromptTextView: View {
    let greeting: String = "혼저옵서!"
    let text: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text(greeting)
            Text(text)
        }
        .font(.custom("GmarketSansMedium", size: 50))
        .foregroundColor(Color("myDarkBlue"))
        .multilineTextAlignment(.center)
    }
}

// MARK: - CustomTextField
/// 닉네임 입력 텍스트 필드
/// - 특징:
///   - 최대 5자까지 입력 가능
///   - Placeholder 표시
struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        TextField("", text: Binding(
            get: { text },
            set: { newValue in
                if newValue.count <= 5 {
                    text = newValue
                }
            }
        ))
        .font(.custom("GmarketSansBold", size: 50))
        .foregroundColor(.black)
        .multilineTextAlignment(.center)
        .focused($isFocused) // 포커스 상태 바인딩
        .placeholder(when: text.isEmpty && !isFocused) { // Placeholder 표시 조건
            Text(placeholder)
                .font(.custom("GmarketSansBold", size: 50))
                .foregroundColor(Color("myGrey05"))
                .multilineTextAlignment(.center)
        }
        .frame(height: 125)
        .padding(.horizontal, 20) 
        .background(
            RoundedRectangle(cornerRadius: 30)
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
        selectedCharacter: "profile_harvang",
        text: "이름을 알려줘!",
        nickname: .constant("테스트")
    )
}
