//
//  NewCharacterView.swift
//  bewavoca-iOS
//
//  Created by Moo on 2024/12/22.
//
//  캐릭터 해금 축하 화면입니다.
//  - 해금된 캐릭터의 축하 이미지 표시
//  - 확인 버튼 클릭 시 메인 화면으로 이동(현재 미구현)

import SwiftUI

struct NewCharacterView: View {
    let characterType: CharacterType
    
    
    @EnvironmentObject private var navigationPathManager : NavigationPathManager
    
    private var unlockedCharacter: UnlockedCharacterContent.Character {
        UnlockedCharacterContent.characters[characterType]!
    }
    
    var body: some View {
        DeviceScaledView{
            ZStack {
                Color("myDarkBlue")
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 43) {
                    Text("새로운 친구를 만났어요!")
                        .font(.custom("GmarketSansBold", size: 70))
                        .foregroundStyle(.white)
                    
                    Image(unlockedCharacter.unlockImage)
                        .frame(width: 495)
                    
                    Button {
                        navigationPathManager.resetToMainView()
                    } label: {
                        Image("btn_confirm")
                            .frame(width: 201)
                    }
                }
                .padding(.top, 30)
            }
        }
    }
}

#Preview {
    NavigationStack {
        NewCharacterView(characterType: .dongbaek)
    }.environmentObject(NavigationPathManager(userViewModel: UserViewModel()))
}
