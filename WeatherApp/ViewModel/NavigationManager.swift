//
//  NavigationManager.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 27/04/2023.
//

import Foundation

class NavigationManager: ObservableObject {
    @Published var showCityChoose: Bool = false
    @Published var isSheetExpanded: Bool = false
    
    static let shared = NavigationManager()
    
    private init() { }
}
