//
//  ArcSliderView.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 27/04/2023.
//

import SwiftUI

struct ArcSliderView: View {
    
    var body: some View {
        ZStack {
            HStack {
                ArcReadingView()
            }
            .zIndex(2)
            ArcPlaceholderView()
                .padding(36)
        }
    }
}

struct ArcSliderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.saphhire
            ArcSliderView()
        }
        
    }
}
