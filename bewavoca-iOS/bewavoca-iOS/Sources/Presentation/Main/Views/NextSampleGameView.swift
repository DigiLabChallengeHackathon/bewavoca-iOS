import SwiftUI

struct NextSampleGameView: View {
    var test: String 
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.title)
                    Text("뒤로 가기")
                        .font(.title3)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            Text(">> \(test)")
        }
        .navigationBarHidden(true)
    }
}
