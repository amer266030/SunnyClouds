//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 3/31/23.
//

import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    @Published var authStatus: Status = .NotDetermined
    @Published var currentLocation: CLLocation?
    @Published var cityName: String = ""
    @Published var countryName: String = ""
    @ObservedObject var weatherFetcher = WeatherFetcher.shared
    private let locationManager = CLLocationManager()
    private var locationCompletion: ((Result<City?, Error>) -> Void)?
    
    static let shared = LocationManager()
    
    private override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    enum Status: String {
        case NotDetermined = "Not Determined",
             AuthorizedWhenInUse = "Authorized When In Use",
             AuthorizedAlways = "Authorized Always",
             Restricted,
             Denied
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined         : authStatus = Status.NotDetermined
        case .authorizedWhenInUse   : authStatus = Status.AuthorizedWhenInUse
        case .authorizedAlways      : authStatus = Status.AuthorizedAlways
        case .restricted            : authStatus = Status.Restricted
        case .denied                : authStatus = Status.Denied
        @unknown default:
            fatalError()
        }
    }
    
    func fetchLocation() async throws -> City? {
       return try await withUnsafeThrowingContinuation { continuation in
           locationCompletion = { result in
               continuation.resume(with: result)
           }
       }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, currentLocation == nil else { return }

        DispatchQueue.main.async { self.currentLocation = location }

        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler:
                                            {
            placemarks, error -> Void in
            // Place details
            guard let placeMark = placemarks?.first else { return }
            self.cityName = placeMark.subAdministrativeArea ?? ""
            self.countryName = placeMark.country ?? ""

            if self.currentLocation != nil && self.weatherFetcher.city == nil {
                self.weatherFetcher.city = City(country: self.countryName,
                                                name: self.cityName,
                                                lat: "\(self.currentLocation!.coordinate.latitude)",
                                                lng: "\(self.currentLocation!.coordinate.longitude)")
                self.locationCompletion?(.success(self.weatherFetcher.city))
            }
        })
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        self.locationCompletion?(.success(City(country: "SA", name: "Riyadh", lat: "24.68773", lng: "46.72185")))
//        locationCompletion?(.failure(error))
    }
}


