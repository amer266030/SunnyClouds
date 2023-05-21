//
//  ReadData.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import SwiftUI

class CityFetcher: ObservableObject  {
    @Published var cities = [City]()
    @Published var filteredCities = [City]()
        
    init(){
        loadData()
    }
    
    func loadData()  {
        DispatchQueue.global().async {
            let decodedData: [City] = Bundle.main.decode(file: "cities.json")
            DispatchQueue.main.async {
                self.cities = decodedData
            }
        }
    }
    
    func filterBy(name: String = "", country: String = "") {
        if !name.isEmpty && !country.isEmpty {
            filteredCities = cities.filter
            { $0.country.lowercased().contains(country.lowercased()) }
                .filter {
                    $0.name.lowercased().contains(name.lowercased())
                }
        }
        else if !name.isEmpty {
            filteredCities = cities.filter
            { $0.name.lowercased().contains(name.lowercased()) }
        }
        else if !country.isEmpty {
            filteredCities = cities.filter
            { $0.country.lowercased().contains(country.lowercased()) }
        }
    }
}
