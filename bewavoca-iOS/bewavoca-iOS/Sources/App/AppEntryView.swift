//
//  AppEntryView.swift
//  bewavoca-iOS
//
//  Created by Moo on 2023/12/30.
//
//  앱의 진입점 뷰입니다.
//  - 스플래시 화면 표시
//  - UUID 존재 여부에 따른 화면 전환 관리
//  - 신규 사용자: 온보딩 화면으로 이동
//  - 기존 사용자: 메인 화면으로 이동 (목데이터 사용)

import SwiftUI

struct AppEntryView: View {
    // MARK: - Properties
    @AppStorage("userUUID") private var userUUID: String?
    @StateObject private var userViewModel: UserViewModel
    @State private var isLoading = true
    @State private var isNewUser: Bool = true
    
    // 생성자에서 초기화
    init() {
        let isExisting = UserDefaults.standard.string(forKey: "userUUID") != nil
        _userViewModel = StateObject(wrappedValue: UserViewModel(isExistingUser: isExisting))
        _isNewUser = State(initialValue: UserDefaults.standard.string(forKey: "userUUID") == nil)
    }
    
    // MARK: - Body
    var body: some View {
        Group {
            if isLoading {
                SplashView()
                    .onAppear {
                        initializeAndProceed()
                    }
            } else if isNewUser {
                OnboardingView()
                    .transition(.opacity)
            } else {
                MainView()
            }
        }
        .environmentObject(userViewModel)
    }
    
    private func initializeAndProceed() {
        if userUUID == nil {
            userUUID = UUID().uuidString
            isNewUser = true
        } else {
            isNewUser = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isLoading = false
        }
    }
}
