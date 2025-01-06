import SwiftUI

struct MainView: View {    
    // MARK: - Body
    var body: some View {
        DeviceScaledView {
            NavigationStack {

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
            }
            .frame(width: 1366, height: 1024)
            .withBackgroundMusic(viewName: String(describing: Self.self))
        }
    }
}

#Preview {
    MainView()
        .environmentObject(UserViewModel.mock)
}
