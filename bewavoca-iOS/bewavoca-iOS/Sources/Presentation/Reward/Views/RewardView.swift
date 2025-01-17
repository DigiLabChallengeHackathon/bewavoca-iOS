//
//  RewardView.swift
//  bewavoca-iOS
//
//  Created by Moo on 2024/12/22.
//
//  스테이지 클리어 후 보상으로 제공되는 캐릭터 획득 화면입니다.
//  캐릭터별로 여러 페이지의 시나리오를 보여주며, 마지막 페이지에서
//  NewCharacterView로 전환됩니다.
//
//  시나리오 구성:
//  - 캐릭터와의 대화 페이지들 (1~n페이지)
//  - 마지막: NewCharacterView로 전환되어 캐릭터 획득 완료

import SwiftUI

struct RewardView: View {
    @EnvironmentObject private var navigationPathManager : NavigationPathManager
    @Environment(\.dismiss) private var dismiss
    let characterType: CharacterType
    @State private var currentPage = 0
    @State private var showNewCharacterView = false
    
    private var scenario: RewardContent.RewardScenario {
        RewardContent.rewardScenarios[characterType]!
    }
    
    private var isLastPage: Bool {
        currentPage == scenario.pages.count - 1
    }
    
    var body: some View {
        DeviceScaledView {
            ZStack {
                WelcomeBackgroundView()

                TapToContinueButton {
                    if isLastPage {
                        showNewCharacterView = true
                    } else {
                        currentPage += 1
                    }
                }
                
                VStack {
                    HStack {
                        CharacterView(page: scenario.pages[currentPage])
                            .padding(.leading, 250)
                        Spacer()
                    }
                    
                    MessageBox(message: scenario.pages[currentPage].message)
                        .padding(.top, 50)
                }
                .padding(.top, 150)
            }
            .fullScreenCover(isPresented: $showNewCharacterView) {
                NewCharacterView(characterType: characterType)
            }
        }
    }
}

private struct CharacterView: View {
    let page: RewardContent.Page
    
    var body: some View {
        Image(page.characterImage)
            .frame(width: 512)
    }
}


private struct MessageBox: View {
    let message: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .frame(width: 1213, height: 266)
            
            Text(message)
                .font(.custom("GmarketSansBold", size: 54))
                .multilineTextAlignment(.center)
                .lineSpacing(30)
        }
    }
}

#Preview {
    RewardView(characterType: .dongbaek)
}
