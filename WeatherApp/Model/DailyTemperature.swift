//
//  DailyTemperature.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import SwiftUI

struct DailyTemperature: Identifiable {
    let day: Date
    let symbolName: String
    let min: Double
    let max: Double
    let sunrise: Date?
    let sunset: Date?
    let uvIndex: Int
    let wind: Double
    let id: String
}
