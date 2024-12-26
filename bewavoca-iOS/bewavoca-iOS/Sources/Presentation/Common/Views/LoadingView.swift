import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            RabongLoadingView()
            Text("잠시만 기다려주세요")
                .font(Font.custom("GmarketSansBold", size: 40)
                )
                .foregroundColor(Color("myDarkBlue"))
                .padding(.top, 41)
            
        }.background(Color.white)
    }
}

#Preview {
    LoadingView()
}
