//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 3/31/23.
//

import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    @Published var currentLocation: CLLocation?
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                             didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {
    
        case .notDetermined         : print("notDetermined")        // location permission not asked for yet
        case .authorizedWhenInUse   : print("authorizedWhenInUse")  // location authorized
        case .authorizedAlways      : print("authorizedAlways")     // location authorized
        case .restricted            : print("restricted")           // TODO: handle
        case .denied                : print("denied")               // TODO: handle
        @unknown default:
            fatalError()
        }
        
        func getPlace(for location: CLLocation,
                          completion: @escaping (CLPlacemark?) -> Void) {
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                
                guard error == nil else {
                    print("*** Error in \(#function): \(error!.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let placemark = placemarks?[0] else {
                    print("*** Error in \(#function): placemark is nil")
                    completion(nil)
                    return
                }
                
                completion(placemark)
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, currentLocation == nil else { return }
        
        DispatchQueue.main.async {
            self.currentLocation = location
        }
    }
}


