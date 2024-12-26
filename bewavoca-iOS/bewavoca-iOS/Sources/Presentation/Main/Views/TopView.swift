import SwiftUI

struct TopView: View {
    @Binding var userData: UserData
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ProfileCard(character: userData.character, nickName: userData.nickname)
                
                NavigationLink(destination: NextSampleGameView(test: "설정")) {
                    Image("btn_setting")
                }
                .frame(width: 78, height: 78)
                .padding(.top, 34)
                .buttonStyle(EffectButtonStyle())
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Image("image_brand")
                    .padding(.top, 11)
                    .frame(width: 293, height: 101)
                Spacer()
            }
            
            Spacer()
            
            Image("image_compass")
                .frame(width: 167, height: 151)
        }
        .frame(width:1366, height: 270)
        .padding(.top, 52)
        .padding(.horizontal, 46)
    }
}

struct ProfileCard: View {
    
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
            .padding([.top, .leading, .bottom], 16)
            .padding([.trailing], 6)
            
            VStack(alignment: .leading) {
                Text("혼저옵서")
                    .font(Font.custom("GmarketSansMedium", size: 30))
                    .foregroundColor(Color("myDarkBlue"))
                
                // 글자 수에 따라 폰트 크기 조절
                Text("\(nickName)")
                    .font(Font.custom("GmarketSansBold", size: fontSize(for: nickName)))
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading) // 너비를 최대한 확장
            }
            .padding(.trailing, 0)
            Spacer()
        }
        .frame(width: 275, height: 141)
        .background(Color.white)
        .modifier(CardModifier())
    }
}

func fontSize(for name: String) -> CGFloat {
    let length = name.count
    switch length {
    case 1...3:
        return 40 // 1~3글자일 때 폰트 크기
    case 4...5:
        return 28 // 4~5글자일 때 폰트 크기
    default:
        return 25 // 그 이상은 작은 폰트
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
    
}

#Preview {
    TopView(userData: .constant(UserData(userId: 4, nickname: "김태인", character: 1, stage: 3, level: 1)))
        .background(Color.black)
}

