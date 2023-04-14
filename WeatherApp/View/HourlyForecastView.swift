//
//  HourlyForecastView.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import SwiftUI
import WeatherKit

struct HourlyForecastView: View {
    
    @Binding var hourWeatherList: [HourlyTemperature]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(hourWeatherList) { hourWeatherItem in
                        VStack {
                            Text(hourWeatherItem.time.formatted(date: .omitted, time: .shortened))
                            Image.weatherDefault
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                
                            Text(hourWeatherItem.temperature.formatted())
                        }
                        .bold()
                        .padding(.horizontal, 4)
                        .frame(width: geo.frame(in: .global).width/5, height: geo.frame(in: .global).width/2.5)
                        .background(LinearGradient(colors: [Color.periwinkle.opacity(0.6), Color.saphhire.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    , in: RoundedRectangle(cornerRadius: .infinity))
                        .overlay {
                            RoundedRectangle(cornerRadius: .infinity)
                                .fill(
                                    .shadow(.inner(color: Color(red: 197/255, green: 197/255, blue: 197/255),radius: 3, x:3, y: 3))
                                    .shadow(.inner(color: .white, radius: 3, x: -3, y: -3))
                                )
                                .opacity(0.2)
                        }
                    }
                }
                .lineLimit(1)
                .font(.caption)
            }
            .padding(.horizontal)
        }
    }
}
