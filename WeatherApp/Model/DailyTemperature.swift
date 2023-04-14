//
//  DailyTemperature.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import Foundation

struct DailyTemperature: Identifiable {
    let day: Date
    let min: Double
    let max: Double
    let sunrise: Date?
    let sunset: Date?
    let id: String
}
