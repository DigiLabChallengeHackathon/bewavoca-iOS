import SwiftUI

struct BottomView: View {
    let navigationPathManager: NavigationPathManager
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Image("big_character_\(navigationPathManager.userViewModel.userData.character)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 261, height: 321)
                    .offset(y: 72)
                
                Button(action: {
                    HapticManager.shared.trigger(.tap)
                    SoundManager.shared.playEffect(.tap)
                    
                    navigationPathManager.navigationPath.append(AppDestination.characterSelect)
                }, label: {
                    Image("btn_character")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 343, height: 143)
                })
            }
        }
        .frame(width: 1366, height: 392)
        .padding(.horizontal, 46)
        .padding(.bottom, 113)
    }
}
