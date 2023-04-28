//
//  ContentView.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 3/31/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var nav = NavigationManager.shared
    
    var body: some View {
        if nav.showCityChoose {
            CityChoose()
        } else {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
