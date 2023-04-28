//
//  DailyForecastView.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 27/04/2023.
//

import SwiftUI

struct DailyForecastView: View {
    @ObservedObject var weatherFetcher = WeatherFetcher.shared
    @Binding var dailyWeatherList: [DailyTemperature]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(dailyWeatherList) { dailyWeatherItem in
                        VStack {
                            Text("\(dailyWeatherItem.day.formatted(Date.FormatStyle().weekday(.abbreviated)))")
                            weatherFetcher.img(fromSF: dailyWeatherItem.symbolName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                
                            Text("L: \(dailyWeatherItem.min.rounded().formatted())")
                            Text("H: \(dailyWeatherItem.max.rounded().formatted())")
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

struct DailyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        DailyForecastView(dailyWeatherList: .constant([DailyTemperature.init(day: Date.now, symbolName: "sun.max.fill", min: 12, max: 19, sunrise: Date.now, sunset: Date.now, uvIndex: 15, wind:0, id: "123")]))
    }
}
