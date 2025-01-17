import SwiftUI

/**
 !!주의!! 아래 버튼은 NavigationLink 로 작업되어 있으므로
 실제 View 를 NavigationStack 으로 감싸야합니다
 */


struct MapView: View {
    @EnvironmentObject private var navigationPathManager : NavigationPathManager
    
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
                
                Button(action: {
                    navigationPathManager.updateStage(to: stage)
                    navigationPathManager.navigationPath.append(AppDestination.stage)
                }) {
                    ImageMapButtonView(
                        shape: shape,
                        stageName: stageName,
                        color: color,
                        // 기존 로직 - stage가 클리어한 스테이지
                        // isOpen: userData.stage >= stage.index,
                        // isActive: userData.stage + 1 == stage.index
                        
                        // 변경 로직 - stage가 현재 도전하는 스테이지
                        isOpen: navigationPathManager.userViewModel.userData.stage > stage.index,
                        isActive: navigationPathManager.userViewModel.userData.stage == stage.index
                    )
                }
                .buttonStyle(BaseButtonStyle())
            }
        }
        .frame(width: 1102 , height: 666)
        .background(Color.clear)
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
