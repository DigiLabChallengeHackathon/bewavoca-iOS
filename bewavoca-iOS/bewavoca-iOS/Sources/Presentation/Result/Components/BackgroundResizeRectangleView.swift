import SwiftUI

struct BackgroundResizeRectangleView<Content: View>: View {
    let content: Content
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .background(Color.white)
            
            content
        }
        .frame(width: width, height: height)
        .cornerRadius(98.51)
    }
    
    init(width: CGFloat, height: CGFloat, @ViewBuilder content: () -> Content) {
        self.width = width
        self.height = height
        self.content = content()
    }
}

struct BackgroundResizeRectangleTestView: View {
    var body: some View {
        DeviceScaledView {
            BackgroundResizeRectangleView(width: 812, height: 554) {
                // testView
                VStack {
                    Text("VIEW SAMPLE")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.pink)
                }
                // testView end
            }
        }
    }
}

#Preview {
    BackgroundResizeRectangleTestView()
}
