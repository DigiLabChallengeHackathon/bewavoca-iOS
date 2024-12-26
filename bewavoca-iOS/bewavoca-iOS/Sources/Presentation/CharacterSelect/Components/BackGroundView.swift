//
//  BackgroundView.swift
//  bewavoca-iOS
//
//  Created by Moo on 2024/12/20.
//
//  캐릭터 선택 화면의 배경을 구성하는 뷰입니다.
//  - 다크블루 색상의 기본 배경
//  - 흰색 라운드 사각형 오버레이
//  - 그림자 효과

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Color("myDarkBlue")
            
            RoundedRectangle(cornerRadius: 98)
                .fill(Color.white)
                .frame(width: 1237, height: 808)
                .shadow(radius: 10)
        }
    }
}
