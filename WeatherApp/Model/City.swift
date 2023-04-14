//
//  City.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import Foundation

struct City: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case country
        case name
        case lat
        case lng
    }
    
    var id = UUID()
    var country: String
    var name: String
    var lat: String
    var lng: String
}

