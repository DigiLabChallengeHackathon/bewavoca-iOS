import SwiftUI

struct MainView: View {
    @EnvironmentObject private var navigationPathManger : NavigationPathManager
    
    var body: some View {
        DeviceScaledView {
            ZStack {
                MapView()
                    .frame(alignment: .center)
                
                VStack {
                    TopView()
                        .frame(alignment: .top)
                    
                    Spacer()
                    
                    BottomView()
                        .frame(alignment: .bottom)
                }
            }
            .background(Color("myDarkBlue"))
            .frame(width: 1366, height: 1024)
            .withBackgroundMusic(viewName: String(describing: Self.self))
        }
        .onAppear(){
            // 게임 설정 초기화
            navigationPathManger.resetGameInfo()
            navigationPathManger.resetResultInfo()
            
        }
    }
}

#Preview {
    NavigationStack {
        MainView()
    }.environmentObject(NavigationPathManager(userViewModel: UserViewModel.mock))
}
