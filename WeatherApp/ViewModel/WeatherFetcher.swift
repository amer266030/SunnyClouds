//
//  WeatherFetcher.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import WeatherKit
import CoreLocation

class WeatherFetcher: ObservableObject {
    @Published var city: City = ReadData().cities.first(where: { $0.name == "Riyadh" })!
    @Published var weather: Weather?
    @Published var hourTemperatures: [HourlyTemperature] = []
    @Published var dailyTemperatures: [DailyTemperature] = []
    
    func fetchDaily() async {
        let weatherService = WeatherService()
        
        do {
            // API Call
            let weather = try await weatherService.weather(for:
                                                            CLLocation(latitude: Double(city.lat)!, longitude: Double(city.lng)!)
            )
            // Daily Forecast
            let dailyForecasts = weather.dailyForecast.forecast
            let dailyTemperatures = Array(
                dailyForecasts.prefix(5)
            ).map {
                DailyTemperature(
                    day: $0.date,
                    min: $0.lowTemperature.value,
                    max: $0.highTemperature.value,
                    sunrise: $0.sun.sunrise,
                    sunset: $0.sun.sunset,
                    id: UUID().uuidString
                )
            }
            // Hourly Forecast
            let hourlyTemperatures = Array(weather.hourlyForecast.filter { hourlyWeather in
                return hourlyWeather.date.timeIntervalSince(Date()) >= 0
            }.prefix(12)).map {
                HourlyTemperature(
                    time: $0.date,
                    temperature: $0.temperature.value,
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
}
