//
//  City.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import Foundation
import MapKit

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
    
    var region: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lng)!), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }
}

