//
//  WeatherFetcher.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import WeatherKit
import CoreLocation
import SwiftUI
import WidgetKit

class WeatherFetcher: ObservableObject {
    @Published var city: City?
    @Published var weather: Weather?
    @Published var hourTemperatures: [HourlyTemperature] = []
    @Published var dailyTemperatures: [DailyTemperature] = []

    static let shared = WeatherFetcher()
    
    private init() { }
    
    @MainActor
    func fetchDaily() async {
        let weatherService = WeatherService()
        
        if city == nil {
            do {
                let locationManager = LocationManager.shared
                city = try await locationManager.fetchLocation()
            } catch {
                return
            }
        }
        
        guard let lat = city?.lat, let lng = city?.lng else { return }
        
        do {
            // API Call
            let weather = try await weatherService.weather(for:
                                                            CLLocation(latitude: Double(lat)!, longitude: Double(lng)!)
            )
            // Daily Forecast
            let dailyForecasts = weather.dailyForecast.forecast
            let dailyTemperatures = Array(
                dailyForecasts.prefix(7)
            ).map {
                DailyTemperature(
                    day: $0.date,
                    symbolName: $0.symbolName,
                    min: $0.lowTemperature.value,
                    max: $0.highTemperature.value,
                    sunrise: $0.sun.sunrise,
                    sunset: $0.sun.sunset,
                    uvIndex: $0.uvIndex.value,
                    wind: $0.wind.speed.value,
                    id: UUID().uuidString
                )
            }
            // Hourly Forecast
            let hourlyTemperatures = Array(weather.hourlyForecast.filter { hourlyWeather in
                return hourlyWeather.date.timeIntervalSince(Date()) >= 0
            }.prefix(12)).map {
                HourlyTemperature(
                    time: $0.date,
                    symbolName: $0.symbolName,
                    temperature: $0.temperature.value,
                    cloudCover: $0.cloudCover,
                    id: UUID().uuidString
                )
            }
            
            DispatchQueue.main.async {
                self.weather = weather
                self.hourTemperatures = hourlyTemperatures
                self.dailyTemperatures = dailyTemperatures
            }
        } catch {
            fatalError("\(error)")
        }
    }
    
    func img(fromSF symbolName: String) -> Image {
        switch symbolName {
        // Sun
        case "sunrise":
            return Image("WeatherIcon - 1-24")
        case "sunset":
            return Image("WeatherIcon - 1-23")
        case "sun.max":
            return Image("WeatherIcon - 2-22")
        case "cloud.sun":
            return Image("WeatherIcon - 2-39")
        case "sun.haze":
            return Image("WeatherIcon - 2-30")
        // Clouds
        case "cloud":
            return Image("WeatherIcon - 2-32")
        case "cloud.fog":
            return Image("WeatherIcon - 2-41")
        case "cloud.drizzle":
            return Image("WeatherIcon - 2-38")
        case "cloud.rain":
            return Image("WeatherIcon - 2-42")
        case "cloud.heavyrain":
            return Image("WeatherIcon - 2-43")
        case "cloud.bolt.rain":
            return Image("WeatherIcon - 2-64")
        case "cloud.sleet":
            return Image("WeatherIcon - 2-36")
        case "cloud.snow":
            return Image("WeatherIcon - 2-35")
        // Moon
        case "moon.stars":
            return Image("WeatherIcon - 2-25")
        case "moon.haze":
            return Image("WeatherIcon - 2-31")
        case "cloud.moon":
            return Image("WeatherIcon - 2-40")
        case "cloud.moon.rain":
            return Image("WeatherIcon - 2-60")
        case "cloud.moon.bolt":
            return Image("WeatherIcon - 2-55")
        // Wind
        case "wind":
            return Image("WeatherIcon - 2-6")
        // Snow
        case "snowflake":
            return Image("WeatherIcon - 1-19")
           
        default:
            return Image(systemName: symbolName)
        }
    }
}
