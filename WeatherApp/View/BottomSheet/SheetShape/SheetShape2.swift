//
//  Shape2.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 27/04/2023.
//

import SwiftUI

struct SheetShape2: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.00094*width, y: 0.99933*height))
        path.addLine(to: CGPoint(x: 0.00094*width, y: 0.03461*height))
        path.addCurve(to: CGPoint(x: 0.49058*width, y: 0.00067*height), control1: CGPoint(x: 0.14846*width, y: 0.01241*height), control2: CGPoint(x: 0.31776*width, y: 0.00067*height))
        path.addCurve(to: CGPoint(x: 0.99906*width, y: 0.03753*height), control1: CGPoint(x: 0.66341*width, y: 0.00067*height), control2: CGPoint(x: 0.84702*width, y: 0.01341*height))
        path.addLine(to: CGPoint(x: 0.99906*width, y: 0.99933*height))
        path.addLine(to: CGPoint(x: 0.00094*width, y: 0.99933*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.49058*width, y: 0.00133*height))
        path.addCurve(to: CGPoint(x: 0.99812*width, y: 0.03807*height), control1: CGPoint(x: 0.67085*width, y: 0.00133*height), control2: CGPoint(x: 0.84631*width, y: 0.01404*height))
        path.addLine(to: CGPoint(x: 0.99812*width, y: 0.99867*height))
        path.addLine(to: CGPoint(x: 0.00188*width, y: 0.99867*height))
        path.addLine(to: CGPoint(x: 0.00188*width, y: 0.03516*height))
        path.addCurve(to: CGPoint(x: 0.49058*width, y: 0.00133*height), control1: CGPoint(x: 0.14915*width, y: 0.01303*height), control2: CGPoint(x: 0.3181*width, y: 0.00133*height))
        path.move(to: CGPoint(x: 0.49058*width, y: 0))
        path.addCurve(to: CGPoint(x: 0, y: 0.03408*height), control1: CGPoint(x: 0.31122*width, y: 0), control2: CGPoint(x: 0.14341*width, y: 0.01244*height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: width, y: 0.037*height))
        path.addCurve(to: CGPoint(x: 0.49058*width, y: 0), control1: CGPoint(x: 0.85254*width, y: 0.01356*height), control2: CGPoint(x: 0.67785*width, y: 0))
        path.addLine(to: CGPoint(x: 0.49058*width, y: 0))
        path.closeSubpath()
        return path
    }
}

struct SheetShape2_Previews: PreviewProvider {
    static var previews: some View {
        SheetShape2()
    }
}
