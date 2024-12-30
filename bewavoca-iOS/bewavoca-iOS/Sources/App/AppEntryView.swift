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
    @AppStorage("userUUID") private var userUUID: String?
    @State private var isLoading = true
    @State private var isNewUser = false  // 신규 사용자 여부
    
    var body: some View {
        if isLoading {
            SplashView()
                .onAppear {
                    // 첫 실행 시에만 UUID 생성
                    if userUUID == nil {
                        userUUID = UUID().uuidString
                        isNewUser = true  // 신규 사용자로 표시
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        isLoading = false
                    }
                }
        } else {
            if isNewUser {
                // 신규 사용자: 온보딩으로
                OnboardingView()
                    .transition(.opacity)
            } else {
                // 기존 사용자: 메인으로 (목데이터 사용)
                MainView()
                    .environmentObject(UserViewModel(isExistingUser: true))
            }
        }
    }
}