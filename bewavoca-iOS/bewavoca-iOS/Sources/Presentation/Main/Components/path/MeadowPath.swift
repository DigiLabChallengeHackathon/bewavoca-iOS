import SwiftUI

struct MeadowPathShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 594, y: 462))
        path.closeSubpath()
        
        path.move(to: CGPoint(x: 752.067, y: 354.534))
        path.addCurve(to: CGPoint(x: 752.291, y: 376.008),
                      control1: CGPoint(x: 749.523, y: 361.477),
                      control2: CGPoint(x: 749.6, y: 369.113))
        path.addLine(to: CGPoint(x: 753.533, y: 379.191))
        path.addCurve(to: CGPoint(x: 727.436, y: 417.39),
                      control1: CGPoint(x: 760.702, y: 397.561),
                      control2: CGPoint(x: 747.154, y: 417.39))
        path.addCurve(to: CGPoint(x: 711.497, y: 422.367),
                      control1: CGPoint(x: 721.74, y: 417.39),
                      control2: CGPoint(x: 716.18, y: 419.126))
        path.addCurve(to: CGPoint(x: 680.05, y: 444.123),
                      control1: CGPoint(x: 711.497, y: 422.367),
                      control2: CGPoint(x: 680.05, y: 444.123))
        path.addCurve(to: CGPoint(x: 645.581, y: 445.42),
                      control1: CGPoint(x: 669.79, y: 451.221),
                      control2: CGPoint(x: 656.346, y: 451.727))
        path.addCurve(to: CGPoint(x: 613.79, y: 445.053),
                      control1: CGPoint(x: 635.794, y: 439.685),
                      control2: CGPoint(x: 623.707, y: 439.546))
        path.addLine(to: CGPoint(x: 558.522, y: 475.745))
        path.addCurve(to: CGPoint(x: 457.397, y: 490.141),
                      control1: CGPoint(x: 527.739, y: 492.84),
                      control2: CGPoint(x: 491.728, y: 497.966))
        path.addCurve(to: CGPoint(x: 417.38, y: 485.532),
                      control1: CGPoint(x: 439.205, y: 485.994),
                      control2: CGPoint(x: 424.611, y: 484.203))
        path.addCurve(to: CGPoint(x: 368.162, y: 469.393),
                      control1: CGPoint(x: 399.298, y: 488.857),
                      control2: CGPoint(x: 380.764, y: 482.779))
        path.addCurve(to: CGPoint(x: 353.603, y: 443.421),
                      control1: CGPoint(x: 366.589, y: 467.721),
                      control2: CGPoint(x: 360.095, y: 460.823))
        path.addLine(to: CGPoint(x: 344.801, y: 460.927))
        path.addCurve(to: CGPoint(x: 324.578, y: 467.549),
                      control1: CGPoint(x: 341.064, y: 468.362),
                      control2: CGPoint(x: 331.989, y: 471.333))
        path.addCurve(to: CGPoint(x: 302.289, y: 473.571),
                      control1: CGPoint(x: 322.69, y: 466.585),
                      control2: CGPoint(x: 315.137, y: 462.728))
        path.addCurve(to: CGPoint(x: 290.44, y: 502.163),
                      control1: CGPoint(x: 305.892, y: 465.894),
                      control2: CGPoint(x: 290.926, y: 497.784))
        path.addLine(to: CGPoint(x: 290.44, y: 591.408))
        path.addCurve(to: CGPoint(x: 303.714, y: 606.308),
                      control1: CGPoint(x: 290.44, y: 599.024),
                      control2: CGPoint(x: 296.148, y: 605.432))
        path.addLine(to: CGPoint(x: 583.583, y: 638.734))
        path.addCurve(to: CGPoint(x: 592.66, y: 636.909),
                      control1: CGPoint(x: 586.725, y: 639.098),
                      control2: CGPoint(x: 589.902, y: 638.459))
        path.addLine(to: CGPoint(x: 845.127, y: 494.992))
        path.addCurve(to: CGPoint(x: 850.718, y: 474.332),
                      control1: CGPoint(x: 852.441, y: 490.881),
                      control2: CGPoint(x: 854.96, y: 481.57))
        path.addLine(to: CGPoint(x: 788.979, y: 368.988))
        path.addCurve(to: CGPoint(x: 779.962, y: 362.095),
                      control1: CGPoint(x: 786.992, y: 365.598),
                      control2: CGPoint(x: 783.755, y: 363.123))
        path.addLine(to: CGPoint(x: 752.067, y: 354.534))
        path.closeSubpath()
        
        return path
    }
}
