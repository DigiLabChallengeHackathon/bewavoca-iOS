//
//  DismissButton.swift
//  bewavoca-iOS
//
//  Created by Moo on 2024/12/20.
//
//  화면 닫기 버튼 컴포넌트입니다.
//  - 우상단에 위치한 X 버튼
//  - 터치 시 현재 화면을 닫음

import SwiftUI

struct DismissButton: View {
    let dismiss: DismissAction
    
    var body: some View {
        Button(action: { dismiss() }) {
            Image("btn_x")
                .frame(width: 78)
        }
        .offset(x: 520, y: -320)
    }
}
