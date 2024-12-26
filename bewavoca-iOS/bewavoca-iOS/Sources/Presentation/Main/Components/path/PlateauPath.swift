import SwiftUI

struct PlateauPathShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // 경로 시작점으로 이동
        path.move(to: CGPoint(x: 362.416, y: 176.19))
        
        // 주어진 경로에 따라 선을 추가
        path.addLine(to: CGPoint(x: 381.879, y: 191.448))
        path.addLine(to: CGPoint(x: 387.513, y: 201.428))
        path.addLine(to: CGPoint(x: 396.305, y: 273.14))
        path.addLine(to: CGPoint(x: 410.575, y: 260.146))
        path.addLine(to: CGPoint(x: 428.343, y: 251.135))
        path.addLine(to: CGPoint(x: 447.839, y: 247.482))
        path.addLine(to: CGPoint(x: 531.193, y: 231.866))
        path.addLine(to: CGPoint(x: 541.444, y: 229.946))
        path.addLine(to: CGPoint(x: 552.043, y: 231.829))
        path.addLine(to: CGPoint(x: 561.005, y: 237.163))
        path.addLine(to: CGPoint(x: 571.369, y: 243.331))
        path.addLine(to: CGPoint(x: 583.852, y: 244.847))
        path.addLine(to: CGPoint(x: 595.391, y: 241.34))
        path.addLine(to: CGPoint(x: 653.35, y: 223.72))
        path.addLine(to: CGPoint(x: 675.101, y: 217.108))
        path.addLine(to: CGPoint(x: 698.604, y: 219.6))
        path.addLine(to: CGPoint(x: 718.485, y: 230.626))
        path.addLine(to: CGPoint(x: 737.005, y: 240.896))
        path.addLine(to: CGPoint(x: 750.949, y: 257.781))
        path.addLine(to: CGPoint(x: 757.541, y: 277.883))
        path.addLine(to: CGPoint(x: 767.605, y: 272.842))
        path.addLine(to: CGPoint(x: 774.247, y: 252.607))
        
        // 경로 끝
        path.addLine(to: CGPoint(x: 774.59, y: 191.109))
        path.addLine(to: CGPoint(x: 780.557, y: 146.009))
        path.addLine(to: CGPoint(x: 742.696, y: 57.6943))
        path.addLine(to: CGPoint(x: 626.595, y: 42.5879))
        path.addLine(to: CGPoint(x: 365.263, y: 148.973))
        path.addLine(to: CGPoint(x: 357.5, y: 152.182))
        
        // 마지막 점까지 경로 추가
        path.addLine(to: CGPoint(x: 362.416, y: 176.19))

        return path
    }
}
