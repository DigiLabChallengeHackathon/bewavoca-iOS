//
//  OnboardingView.swift
//  bewavoca-iOS
//
//  Created by [작성자] on [날짜].
//
//  온보딩 화면을 표시하는 메인 뷰입니다.
//  - 총 7개의 온보딩 페이지를 순차적으로 표시
//  - TapToContinueButton을 통한 페이지 전환
//  - 마지막 페이지에서 닉네임 생성 뷰로 이동

import SwiftUI

// 뷰 전환간 애니메이션은 일단 넣지 않았습니다.
struct OnboardingView: View {
    @EnvironmentObject private var navigationPathManager : NavigationPathManager
    
    @State private var currentPage: OnboardingPage = .page1
    @State private var isShowingNicknameView = false
    
    var body: some View {
        DeviceScaledView {
            ZStack {
                switch currentPage {
                case .page1:
                    OnboardingView1()
                case .page2:
                    OnboardingView2()
                case .page3:
                    OnboardingView3()
                case .page4:
                    OnboardingView4()
                case .page5:
                    OnboardingView5()
                case .page6:
                    OnboardingView6()
                case .page7:
                    OnboardingView7()
                }
                
                TapToContinueButton {
                    if currentPage == .page7 {
                        isShowingNicknameView = true
                    } else {
                        currentPage = OnboardingPage(rawValue: currentPage.rawValue + 1) ?? .page7
                    }
                }
            }
        }
        .navigationDestination(isPresented: $isShowingNicknameView) {
            CreateNicknameView()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .withBackgroundMusic(viewName: String(describing: Self.self))
    }
}

#Preview {
    OnboardingView()
        .environmentObject(NavigationPathManager(userViewModel: UserViewModel()))
}
