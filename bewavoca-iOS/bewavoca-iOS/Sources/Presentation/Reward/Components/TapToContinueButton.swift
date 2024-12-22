//
//  TapToContinueButton.swift
//  bewavoca-iOS
//
//  Created by Moo on 2024/12/22.
//
//  화면 터치로 다음 페이지로 넘어가는 버튼 컴포넌트입니다.
//  - 화면 전체를 버튼으로 사용
//  - 일반 페이지: 다음 페이지로 전환
//  - 마지막 페이지: NewCharacterView로 전환

import SwiftUI

struct TapToContinueButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Color.clear
                .frame(width: DeviceConstant.baseWidth, height: DeviceConstant.baseHeight)
                .contentShape(Rectangle())
        }
    }
}
