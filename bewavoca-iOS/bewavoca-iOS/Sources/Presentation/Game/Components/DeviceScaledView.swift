import SwiftUI


// MARK: - Constants ipad 12.9 landscape
struct DeviceConstant {
   static let baseWidth: CGFloat = 1366
   static let baseHeight: CGFloat = 1024
}

// MARK: - DeviceScaledView
struct DeviceScaledView<Content: View>: View {
    let content: Content
    let baseWidth: CGFloat
    let baseHeight: CGFloat
    
    init(baseWidth: CGFloat = DeviceConstant.baseWidth, baseHeight: CGFloat = DeviceConstant.baseHeight, @ViewBuilder content: () -> Content) {
        self.baseWidth = baseWidth
        self.baseHeight = baseHeight
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            let scale = min(geometry.size.width / baseWidth, geometry.size.height / baseHeight)
            
            self.content
                .scaleEffect(scale)
                .frame(width: geometry.size.width, height: geometry.size.height)
        }.background(Color("myDarkBlue"))
    }
}
