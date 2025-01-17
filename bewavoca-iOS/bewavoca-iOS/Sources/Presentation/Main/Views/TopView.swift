import SwiftUI

struct TopView: View {
    @EnvironmentObject private var navigationPathManager : NavigationPathManager
    
    var body: some View {
        HStack {
            VStackLayout(alignment: .leading) {
                ProfileCard(character: navigationPathManager.userViewModel.userData.character, nickName: navigationPathManager.userViewModel.userData.nickname)
                
                NavigationLink(destination: NextSampleGameView(test: "설정")) {
                    Image("btn_setting")
                }
                .frame(width: 78, height: 78)
                .padding(.top, 34)
                .buttonStyle(EffectButtonStyle())
            }
            .frame(width: 275)
            
            Spacer()
            
            VStack(alignment: .center) {
                Image("image_brand")
                    .padding(.top, 11)
                    .frame(width: 293, height: 101)
                Spacer()
            }
            
            Spacer()
            
            VStack {
                Image("image_compass")
                    .frame(width: 167, height: 151)
                    .padding(.leading, 107)
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .topTrailing)
        }
        .frame(height: 270)
        .padding(.top, 52)
        .padding(.horizontal, 46)
        
    }
    
    private struct ProfileCard: View {
        
        var character: Int
        var nickName: String
        
        var body: some View {
            HStack(alignment: .center) {
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .foregroundColor(Color("myDarkBlue"))
                    
                    Image("character_\(character)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 105, height: 105)
                }
                .frame(width: 105, height: 105)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding([.top, .leading, .bottom], 18)
                .padding(.trailing, 16)
                
                VStack {
                    Text("혼저옵서")
                        .font(Font.custom("GmarketSansMedium", size: 30))
                        .foregroundColor(Color("myDarkBlue"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // 글자 수에 따라 폰트 크기 조절
                    Text("\(nickName)")
                        .font(Font.custom("GmarketSansBold", size: fontSize(for: nickName)))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.frame(width: 118)
                    .padding(.trailing, 20)
            }
            .frame(width: 275, height: 141)
            .background(Color.white)
            .modifier(CardModifier())
        }
        
        private func fontSize(for name: String) -> CGFloat {
             let length = name.count
             switch length {
             case 1...3:
                 return 40 // 1~3글자일 때 폰트 크기
             case 4:
                 return 30 // 4글자일 때 폰트 크기
             case 5:
                 return 24 // 5글자일 때 폰트 크기
             default:
                 return 22 // 그 이상은 작은 폰트
             }
         }
        
        private struct CardModifier: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
            }
            
        }
    }
}

