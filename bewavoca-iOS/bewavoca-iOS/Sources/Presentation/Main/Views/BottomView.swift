import SwiftUI

struct BottomView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var showCharacterSelect = false
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Image("big_character_\(userViewModel.userData.character)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 261, height: 321)
                    .offset(y: 72)
                
                Button(action: {
                    showCharacterSelect = true
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
        .fullScreenCover(isPresented: $showCharacterSelect) {
            CharacterSelectionView()
        }
    }
}
