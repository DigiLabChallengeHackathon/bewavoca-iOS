import SwiftUI

struct NewCharacterView: View {
    let characterType: CharacterType
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        DeviceScaledView{
            ZStack {
                Color("myDarkBlue")
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 43) {
                    Text("새로운 친구를 만났어요!")
                        .font(.custom("GmarketSansBold", size: 70))
                        .foregroundStyle(.white)
                    
                    Image("character_unlock_dongbaek")
                        .frame(width: 495)
                    
                    Button {
                        dismiss()
                    } label: {
                        Image("btn_confirm")
                            .frame(width: 201)
                    }
                }
                .padding(.top, 30)
            }
        }
    }
}

#Preview {
    NewCharacterView(characterType: .dongbaek)
}
