//
//  AppEntryView.swift
//  bewavoca-iOS
//
//  Created by Moo on 2025/02/01.
//
//  앱의 진입점 뷰입니다.
//  - 스플래시 화면 표시
//  - UUID 존재 여부에 따른 화면 전환 관리
//  - 신규 사용자: 온보딩 화면으로 이동
//  - 기존 사용자: 메인 화면으로 이동 (목데이터 사용)

import SwiftUI

struct AppEntryView: View {
    @AppStorage("userUUID") private var userUUID: String?
    @StateObject private var userViewModel: UserViewModel
    @State private var isLoading = true
    @State private var isNewUser: Bool = true
    
    private let authService: AuthService = AuthServiceImpl()
    
    init() {
        _userViewModel = StateObject(wrappedValue: UserViewModel())
        _isNewUser = State(initialValue: true)
    }
    
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
        }
        
        Task {
            do {
                let response = try await authService.checkDevice(deviceId: userUUID ?? "")
                guard let userData = response.data else {
                    isNewUser = true
                    print("❌ 사용자 데이터가 없음")
                    return
                }
                
                isNewUser = false
                
                DispatchQueue.main.async {
                    userViewModel.userData = UserData(
                        userId: userData.userid,
                        nickname: userData.nickname,
                        character: userData.character,
                        region: userData.region,
                        level: userData.level
                    )
                }
                
                print("✅ 디바이스 체크 성공 및 사용자 데이터 불러오기: \(userData)")
            } catch {
                isNewUser = true
                print("❌ 디바이스 체크 실패: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                isLoading = false
            }
        }
    }
}
