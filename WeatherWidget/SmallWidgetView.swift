//
//  SmallWidgetView.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 24/05/2023.
//

import SwiftUI
import WeatherKit
import WidgetKit

struct SmallWidgetView: View {
    var weatherFetcher = WeatherFetcher.shared
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            
            ContainerRelativeShape()
                .fill(Color.Kakitsubata)
                .blur(radius: 0.5)
            
            ContainerRelativeShape()
                .fill(Color.saphhire.gradient)
                .cornerRadius(16)
                .padding()
                
            VStack {
                Text("\(entry.weather?.currentWeather.temperature.value.rounded().formatted() ?? "?") ºC")
                    .font(.title3)
                Text(entry.city?.name ?? "⁉️?")
                    .font(.caption)
            }
            
            VStack {
                HStack {
                    weatherFetcher.img(fromSF: entry.weather?.currentWeather.symbolName ?? "cloud")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60)
                        .padding(8)
                    Spacer()
                }
                Spacer()
                
                HStack {
                    Text("\(entry.weather?.currentWeather.condition.description ?? "🌚?")")
                    Spacer()
                    Text("\(entry.dailyTemp?.first?.wind ?? 0, specifier: "%0.f") km/h")
                }
                .font(.caption2)
                .padding([.horizontal, .bottom], 24)
            }
        }
        .foregroundColor(.white)
    }
}
