import SwiftUI

/**
 !!주의!! 아래 버튼은 NavigationLink 로 작업되어 있으므로
 실제 View 를 NavigationStack 으로 감싸야합니다
 */

enum Stage: CaseIterable, CustomStringConvertible {
    case garden, plateau, village, meadow, ridge
    
    var index: Int {
        switch self {
        case .garden: return 1
        case .plateau: return 2
        case .village: return 3
        case .meadow: return 4
        case .ridge: return 5
        }
    }
    
    var description: String {
        switch self {
        case .garden: return "garden"
        case .plateau: return "plateau"
        case .village: return "village"
        case .meadow: return "meadow"
        case .ridge: return "ridge"
        }
    }
}

struct MapView: View {
    @Binding var userData: UserData
    
    private let stages: [(Stage, AnyShape, String, Color)] = [
        (.garden, AnyShape(GardenPathShape()), "garden", Color("myRed")),
        (.plateau, AnyShape(PlateauPathShape()), "plateau", Color("myBrown")),
        (.village, AnyShape(VillagePathShape()), "village", Color("myYellow")),
        (.meadow, AnyShape(MeadowPathShape()), "meadow", Color("myOrange")),
        (.ridge, AnyShape(RidgePathShape()), "ridge", Color("myGreen"))
    ]
    
    var body: some View {
        ZStack {
            Image("map_gray_all")
                .resizable()
                .scaledToFit()
            
            ForEach(stages, id: \.0) { stage, shape, stageName, color in
                // 각 버튼에 따라 NextSampleView 화면 전환
                NavigationLink(
                    destination: destinationView(for: stage)
                ) {
                    ImageMapButtonView(
                        shape: shape,
                        stageName: stageName,
                        color: color,
                        isOpen: userData.stage >= stage.index,
                        isActive: userData.stage + 1 == stage.index
                    )
                }
                .buttonStyle(BaseButtonStyle())
            }
        }
        .frame(width: 1102 , height: 666)
        .background(Color.clear)
    }
    
    
    private func destinationView(for stage: Stage) -> some View {
        print("?????????????//")
        switch stage {
        case .garden:
            return AnyView(NextSampleGameView(test: "\(stage) garden"))
        case .plateau:
            return AnyView(NextSampleGameView(test: "\(stage) plateau"))
        case .village:
            return AnyView(NextSampleGameView(test: "\(stage) village"))
        case .meadow:
            return AnyView(NextSampleGameView(test: "\(stage) meadow"))
        case .ridge:
            return AnyView(NextSampleGameView(test: "\(stage) ridge"))
            
        }
    }
}

struct ImageMapButtonView<ShapeType: Shape>: View {
    var shape: ShapeType
    var stageName: String
    var color: Color
    var isOpen: Bool
    var isActive: Bool
    
    @State private var opacity: Double = 0.0
    
    var body: some View {
        ZStack {
            Image(isActive ? "map_gray_\(stageName)" : "map_color_\(stageName)")
                .resizable()
                .scaledToFit()
                .opacity(isOpen ? 1 : 0.01)
            
            shape
                .fill(Color.clear)
                .stroke(color, lineWidth: isActive ? 10 : 0)
                .zIndex(isActive ? 2 : 0)
            
            if isActive {
                shape
                    .fill(color)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(
                            Animation.easeInOut(duration: 0.6)
                                .repeatForever(autoreverses: true)
                        ) {
                            opacity = 0.3
                        }
                    }
            }
        }
        .contentShape(shape)
    }
}


#Preview {
    MapView(userData: .constant(UserData(userId: 4, nickname: "김태인", character: 1, stage: 3, level: 1)))
}
