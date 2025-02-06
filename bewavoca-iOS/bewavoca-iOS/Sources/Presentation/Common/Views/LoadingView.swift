import SwiftUI

struct LoadingView: View {
    @EnvironmentObject private var navigationPathManager : NavigationPathManager
    
    var body: some View {
        VStack {
            RabongLoadingView()
            Text("잠시만 기다려주세요")
                .font(Font.custom("GmarketSansBold", size: 40)
                )
                .foregroundColor(Color("myDarkBlue"))
                .padding(.top, 41)
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                checkUserInfo()
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func checkUserInfo() {
        if navigationPathManager.userViewModel.userData.nickname.isEmpty {
            navigationPathManager.navigationPath.append(AppDestination.onboarding)
        } else {
            navigationPathManager.navigationPath.append(AppDestination.main)
        }
    }
}

#Preview {
    LoadingView().environmentObject(NavigationPathManager(userViewModel: UserViewModel()))
}

