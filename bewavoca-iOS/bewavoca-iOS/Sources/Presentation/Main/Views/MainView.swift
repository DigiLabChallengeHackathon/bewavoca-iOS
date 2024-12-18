import SwiftUI

struct MainView: View {
    @State private var userData = UserData(userId: 4, nickname: "김태인", character: 1, stage: 3, level: 1)
    
    var body: some View {
        DeviceScaledView {
            NavigationStack{
                ZStack {
                    MapView(userData: $userData)
                        .frame(alignment: .center)
                    
                    VStack{
                        TopView(userData: $userData)
                            .frame(alignment: .top)
                        
                        Spacer()
                        
                        BottomView(userData: $userData)
                            .frame(alignment: .bottom)
                    }
                }
                .background(Color("myDarkBlue"))
            }.frame(width: 1366, height: 1024)
        }
    }
}

#Preview {
    MainView()
}

