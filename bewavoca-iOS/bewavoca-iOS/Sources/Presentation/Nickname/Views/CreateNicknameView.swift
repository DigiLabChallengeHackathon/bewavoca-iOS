//
//  CreateNicknameView.swift
//  bewavoca-iOS
//
//  Created by Muchan Kim on 12/11/24.
//

import SwiftUI

// MARK: - CreateNicknameView
/// 사용자의 닉네임을 생성하는 첫 화면입니다!
/// 이 화면에서는 사용자에게 닉네임을 입력받고, 입력된 값에 따라 버튼의 상태가 활성화됩니다.
/// - 화면에 표시되는 내용:
///   - 메인 타이틀 이미지를 상단에 표시.
///   - `NicknameCardView`를 통해 닉네임 입력을 받음.
///   - 닉네임이 입력되면 `시작` 버튼이 활성화되어 다음 화면으로 진행할 수 있음.
struct CreateNicknameView: View {
    @State private var nickname: String = ""
    @State private var isButtonPressed: Bool = false
    
    private var isButtonEnabled: Bool {
        return nickname.count >= 1
    }
    
    var body: some View {
        DeviceScaledView {
            ZStack {
                Color("myDarkBlue")
                    .ignoresSafeArea()
                
                VStack(spacing: 70) {
                    TitleView()
                    
                    NicknameCardView(
                        selectedCharacter: "character_card_harbang",
                        text: "이름을 알려줘",
                        nickname: $nickname  // 추후 $viewModel.nickname와 같이 사용하면 됨.
                    )

                    // 추후 viewModel에서 버튼 상태 관리, 유저 생성 기능까지 추가할 것.
                    StartButtonView(
                        isButtonPressed: $isButtonPressed,
                        isButtonEnabled: isButtonEnabled

                        // isEnabled: viewModel.isButtonEnabled, isLoading: viewModel.isLoading
                    )   // viewModel.createUser()
                }
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - TitleView
// 상단 제목 타이틀 뷰
struct TitleView: View {
    var body: some View {
        Image("text_maintitle")
            .frame(width: 293)
    }
}

// MARK: - StartButtonView
// 하단 버튼 뷰
struct StartButtonView: View {
    @Binding var isButtonPressed: Bool
    let isButtonEnabled: Bool
    
    var body: some View {
        Button(action: {
            if isButtonEnabled {
                isButtonPressed.toggle()
            }
        }) {
            Image(isButtonEnabled ? "button_start_pressed" : "button_start_default")
                .frame(height: 157)
        }
        .disabled(!isButtonEnabled)
    }
}

// MARK: - Preview
#Preview {
    CreateNicknameView()
}
