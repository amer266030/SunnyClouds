//
//  WeatherWidgetTimeline.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 18/05/2023.
//

import WidgetKit
import SwiftUI
import Intents
import WeatherKit

struct Provider: IntentTimelineProvider {
    let weatherFetcher = WeatherFetcher.shared
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), city: nil, weather: nil, dailyTemp: nil)
    }

    @MainActor
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task {
            await weatherFetcher.fetchDaily()
            DispatchQueue.main.async {
                let entry = SimpleEntry(date: Date(), configuration: configuration, city: weatherFetcher.city, weather: weatherFetcher.weather, dailyTemp: weatherFetcher.dailyTemperatures)
                completion(entry)
            }
        }
    }
    
    @MainActor
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        Task {
            await weatherFetcher.fetchDaily()
            DispatchQueue.main.async {
                let entry = SimpleEntry(date: Date(), configuration: configuration, city: weatherFetcher.city, weather: weatherFetcher.weather, dailyTemp: weatherFetcher.dailyTemperatures)
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                completion(timeline)
            }
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let city: City?
    let weather: Weather?
    let dailyTemp: [DailyTemperature]?
}
