//
//  sampleView.swift
//  bewavoca-iOS
//
//  Created by Muchan Kim on 12/17/24.
//
import SwiftUI

struct BackView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct StageDetailView: View {
    let stageNumber: Int
    
    var body: some View {
        VStack {
            Text("스테이지 \(stageNumber)")
                .font(.title)
        }
    }
}

struct OXGameView: View {
    var body: some View {
        VStack {
            Text("OXQuiz")
                .font(.title)
        }
    }
}

struct FourChoiceGameView: View {
    var body: some View {
        VStack {
            Text("fourChoiceGameView")
                .font(.title)
        }
    }
}

struct CardGameView: View {
    var body: some View {
        VStack {
            Text("CardGameView")
                .font(.title)
        }
    }
}
