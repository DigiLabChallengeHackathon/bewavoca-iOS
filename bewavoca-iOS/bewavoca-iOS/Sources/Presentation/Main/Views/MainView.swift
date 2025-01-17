import SwiftUI

struct MainView: View {
    @EnvironmentObject private var navigationPathManager : NavigationPathManager
    
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
            navigationPathManager.resetGameInfo()
            navigationPathManager.resetResultInfo()
            
        }
    }
}

#Preview {
    NavigationStack {
        MainView()
    }.environmentObject(NavigationPathManager(userViewModel: UserViewModel.mock))
}
