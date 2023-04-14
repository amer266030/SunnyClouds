//
//  SunsetView.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import SwiftUI
import WeatherKit

struct SunsetView: View {
    
    var weather: Weather?
    
    var body: some View {
        HStack(spacing: 32) {
            Image.sunHaze
                .font(.largeTitle)
                .bold()
            
            if let weather {
                VStack(alignment: .leading) {
                    Text("\(weather.currentWeather.temperature)")
                    Text("5:51 PM")
                        .bold()
                }
                
                VStack(alignment: .leading) {
                    Text("Sunrise")
                    Text("7:00 AM")
                        .bold()
                }
            } else {
                VStack(alignment: .leading) {
                    Text("Sunset")
                    Text("5:51 PM")
                        .bold()
                }
                
                VStack(alignment: .leading) {
                    Text("Sunrise")
                    Text("7:00 AM")
                        .bold()
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            LinearGradient(colors: [Color.white.opacity(0.5), Color.saphhire.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                        , in: RoundedRectangle(cornerRadius: 16, style: .continuous)
        )
        .padding(.horizontal, 40)
    }
}

struct SunsetView_Previews: PreviewProvider {
    static var previews: some View {
        SunsetView(weather: nil)
    }
}
