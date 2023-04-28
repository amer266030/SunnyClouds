//
//  HourlyTemperature.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import SwiftUI

struct HourlyTemperature: Identifiable {
    let time: Date
    let symbolName: String
    let temperature: Double
    let cloudCover: Double
    let id: String
}
