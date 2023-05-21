//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Amer Alyusuf on 18/05/2023.
//

import WidgetKit
import SwiftUI
import Intents

struct WeatherWidgetEntryView : View {
    let weatherFetcher = WeatherFetcher.shared
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(LinearGradient(colors: [Color.periwinkle, Color.saphhire], startPoint: .leading, endPoint: .trailing))
                .overlay(LinearGradient(colors: [Color.white.opacity(0.25), Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing))
            VStack(spacing: 0) {
                // MARK: - Top Text
                HStack(alignment: .top) {
                    HStack(spacing: 0) {
                        weatherFetcher.img(fromSF: entry.weather?.currentWeather.symbolName ?? "cloud")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                        Text("\(entry.weather?.currentWeather.temperature.value.rounded().formatted() ?? "?") ºC")
                            .font(.title3)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing, spacing: 4) {
                            Text(entry.city?.name ?? "⁉️?")
                                .bold()
                            Text("\(entry.weather?.currentWeather.condition.description ?? "🌚?")")
                            Text("\(entry.dailyTemp?.first?.wind ?? 0, specifier: "%0.f") km/h")
                        }
                    }
                    .font(.caption)
                    .frame(maxWidth: .infinity)
                }
                .frame(maxHeight: .infinity)
                
                Spacer()
                
                // MARK: - Bottom Reading
                HStack(alignment: .bottom) {
                    if entry.dailyTemp != nil {
                        ForEach(entry.dailyTemp!) { daily in
                            InfoCardView(img: weatherFetcher.img(fromSF: daily.symbolName),
                                         title: "\(daily.day.formatted(Date.FormatStyle().weekday(.abbreviated)))",
                                         reading: "\( Int(daily.max.rounded() + daily.min.rounded()) / 2)ºC")
                        }
                    }
                }
            }
            .padding()
            .foregroundColor(.white)
        }
    }
}

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("SunnyClouds")
        .description("Weather App widget")
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    
    static var previews: some View {
        WeatherWidgetEntryView(entry: SimpleEntry(date: Date(),
                                                  configuration: ConfigurationIntent(),
                                                  city: City(country: "", name: "Rio", lat: "", lng: ""),
                                                  weather: nil,
                                                  dailyTemp: [DailyTemperature(day: .now, symbolName: "sun.max", min: 10, max: 14, sunrise: .now, sunset: .now, uvIndex: 4, wind: 20, id: "1")]
                                                 )
        )
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
