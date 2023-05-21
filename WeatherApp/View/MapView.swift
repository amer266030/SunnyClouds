//
//  MapView.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 27/04/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @ObservedObject var weatherFetcher = WeatherFetcher.shared

    var body: some View {
        if let city = weatherFetcher.city {
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(city.lat)!, longitude: Double(city.lng)!), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))))
                .aspectRatio(2, contentMode: .fit)
                .cornerRadius(16)
                .padding()
                .onAppear {
                    MKMapView.appearance().mapType = .standard
                }
        }
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
