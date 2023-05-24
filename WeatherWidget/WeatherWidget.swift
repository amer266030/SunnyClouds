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
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
            MediumWidgetView(entry: entry)
        @unknown default:
            EmptyView()
        }
    }
}

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium, .systemSmall])
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
                                                  dailyTemp: [
                                                    DailyTemperature(day: .now, symbolName: "sun.max", min: 10, max: 14, sunrise: .now, sunset: .now, uvIndex: 4, wind: 20, id: "1"),
                                                    DailyTemperature(day: .now, symbolName: "cloud", min: 10, max: 17, sunrise: .now, sunset: .now, uvIndex: 4, wind: 20, id: "1"),
                                                    DailyTemperature(day: .now, symbolName: "cloud.fog", min: 10, max: 24, sunrise: .now, sunset: .now, uvIndex: 4, wind: 20, id: "1"),
                                                    DailyTemperature(day: .now, symbolName: "sun.max", min: 10, max: 34, sunrise: .now, sunset: .now, uvIndex: 4, wind: 20, id: "1"),
                                                    DailyTemperature(day: .now, symbolName: "sun.max", min: 10, max: 12, sunrise: .now, sunset: .now, uvIndex: 4, wind: 20, id: "1"),
                                                    DailyTemperature(day: .now, symbolName: "cloud.bolt.rain", min: 7, max: 12, sunrise: .now, sunset: .now, uvIndex: 4, wind: 20, id: "1")]
                                                 )
        )
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
