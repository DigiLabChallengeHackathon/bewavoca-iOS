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

    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("myDarkBlue")
                    .ignoresSafeArea()

                VStack(spacing: 30) {
                    Image("maintitle")
                        .frame(height: geometry.size.height * 0.15)
                        .padding(.top, geometry.size.height * 0.05)

                    Spacer()
                    
                    // MARK: - CardView
                    ///  selectedCharacter - 메인 캐릭터
                    ///  text: 인삿말 다음 올 텍스트, 이름 변경 시 재활용을 위해 별도로 만듦
                    ///  nickname: 닉네임을 담을 variable
                    NicknameCardView(
                        selectedCharacter: "profile_harvang",
                        text: "이름을 알려줘",
                        nickname: $nickname
                    )
                    .frame(height: geometry.size.height * 0.1)

                    Spacer()

                    Button(action: {
                        // 버튼이 활성화된 상태에서만 눌리도록
                        if isButtonEnabled {
                            isButtonPressed.toggle()
                        }
                    }) {
                        // 버튼의 이미지가 활성화 여부에 따라 다르게 표시
                        Image(isButtonEnabled ? "startButton_pressed" : "startButton_default")
                    }
                    // 버튼이 비활성화 상태일 때는 눌리지 않도록 설정
                    .disabled(!isButtonEnabled)
                    .padding(.bottom, geometry.size.height * 0.05)
                }
                .padding(.horizontal)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - Preview
#Preview {
    CreateNicknameView()
}
