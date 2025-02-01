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
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var nickname: String = ""
    @State private var isButtonPressed: Bool = false
    @State private var isShowingMainView: Bool = false
    private let authService: AuthService = AuthServiceImpl()
    
    private var isButtonEnabled: Bool {
        return nickname.count >= 1
    }
    
    // MARK: - Body
    var body: some View {
        if isShowingMainView {
            MainView()
        } else {
            DeviceScaledView {
                ZStack {
                    Color("myDarkBlue")
                        .ignoresSafeArea()
                    
                    VStack(spacing: 70) {
                        TitleView()
                        
                        NicknameCardView(
                            selectedCharacter: "character_card_harbang",
                            text: "이름을 알려줘",
                            nickname: $nickname
                        )
                        
                        StartButtonView(
                            isButtonPressed: $isButtonPressed,
                            isButtonEnabled: isButtonEnabled,
                            action: {
                                Task {
                                    do {
                                        let response = try await authService.signUp(
                                            deviceId: UserDefaults.standard.string(forKey: "userUUID") ?? "",
                                            nickname: nickname
                                        )
                                        
                                        if let signUpData = response.data {
                                            DispatchQueue.main.async {
                                                userViewModel.userData.userId = signUpData.userId
                                                userViewModel.userData.nickname = signUpData.nickname
                                                isShowingMainView = true
                                            }
                                        }
                                        
                                        print("✅ Signup successful")
                                    } catch {
                                        print("❌ Signup failed: \(error.localizedDescription)")
                                    }
                                }
                            }
                        )
                    }
                }
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}

// MARK: - Preview
#Preview {
    CreateNicknameView()
        .environmentObject(UserViewModel())
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
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            if isButtonEnabled {
                isButtonPressed.toggle()
                action()
            }
        }) {
            Image(isButtonEnabled ? "button_start_pressed" : "button_start_default")
                .frame(height: 157)
        }
        .disabled(!isButtonEnabled)
    }
}
