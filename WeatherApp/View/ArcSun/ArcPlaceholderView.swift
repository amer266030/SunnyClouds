//
//  ArcPlaceholderView.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 27/04/2023.
//

import SwiftUI

struct ArcPlaceholderView: View {
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.55, to: 0.95)
                .stroke(Color.white.gradient
                    .shadow(.inner(color: .white, radius: 1)), lineWidth: 1)
                .blur(radius: 2)
                .opacity(0.3)
            
            Circle()
                .trim(from: 0.6, to: 0.9)
                .stroke(Color.white.gradient
                    .shadow(.inner(color: .white, radius: 1)), lineWidth: 1)
                .blur(radius: 2)
                .opacity(0.3)
            
            Circle()
                .trim(from: 0.65, to: 0.85)
                .stroke(Color.white.gradient
                    .shadow(.inner(color: .white, radius: 1)), lineWidth: 1)
                .blur(radius: 2)
                .opacity(0.3)
        }
    }
}

struct CircularPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.saphhire
            ArcPlaceholderView()
        }
    }
}
