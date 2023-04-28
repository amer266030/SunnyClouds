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
        guard let url = Bundle.main.url(forResource: "cities", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        let cities = try? JSONDecoder().decode([City].self, from: data!)
        self.cities = cities!
        
    }
    
    func filterBy(name: String = "") {
        filteredCities = name.isEmpty ? [] : cities.filter
        { $0.name.lowercased().contains(name.lowercased()) }
    }
     
}
