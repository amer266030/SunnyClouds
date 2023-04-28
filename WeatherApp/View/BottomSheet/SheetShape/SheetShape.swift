//
//  SheetShape.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import SwiftUI

struct SheetShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.99914*width, y: 0.19528*height))
        path.addLine(to: CGPoint(x: 0.99914*width, y: 0.99929*height))
        path.addLine(to: CGPoint(x: 0.00086*width, y: 0.99929*height))
        path.addLine(to: CGPoint(x: 0.00086*width, y: 0.19528*height))
        path.addCurve(to: CGPoint(x: 0.02461*width, y: 0.17284*height), control1: CGPoint(x: 0.00852*width, y: 0.18762*height), control2: CGPoint(x: 0.01643*width, y: 0.18013*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.00071*height), control1: CGPoint(x: 0.14286*width, y: 0.06697*height), control2: CGPoint(x: 0.31208*width, y: 0.00071*height))
        path.addCurve(to: CGPoint(x: 0.97539*width, y: 0.17284*height), control1: CGPoint(x: 0.68792*width, y: 0.00071*height), control2: CGPoint(x: 0.85714*width, y: 0.06697*height))
        path.addCurve(to: CGPoint(x: 0.99914*width, y: 0.19528*height), control1: CGPoint(x: 0.98357*width, y: 0.18013*height), control2: CGPoint(x: 0.99148*width, y: 0.18762*height))
        path.closeSubpath()
        return path
    }
}

struct SheetShape_Previews: PreviewProvider {
    static var previews: some View {
        SheetShape()
    }
}
