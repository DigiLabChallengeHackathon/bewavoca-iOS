import SwiftUI

// MARK: - BackgroundRectangleView
struct BackgroundRectangleView<Content: View>: View {
    let content: Content
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .background(Color.white)
            
            content
        }
        .frame(width: 1094, height: 856)
        .cornerRadius(98.51)
    }
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}

// MARK: - BackgroundRectangleTestView
struct BackgroundRectangleTestView: View {
    var body: some View {
        DeviceScaledView {
            BackgroundRectangleView {
                
                // testView
                GeometryReader { geometry in
                    VStack {
                        Text("GREEN VIEW SAMPLE")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.green)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                // testView end
                
            }
        }
    }
}

#Preview {
    BackgroundRectangleTestView()
}

