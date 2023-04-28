//
//  CityChoose.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import SwiftUI

struct CityChoose: View {
    @ObservedObject var nav = NavigationManager.shared
    @ObservedObject var weatherFetcher = WeatherFetcher.shared
    @ObservedObject var datas = CityFetcher()
    @State private var searchText = ""
           
       var body: some View {
           ZStack {
               ContainerRelativeShape()
                   .fill(Color.periwinkle.gradient)
                   .ignoresSafeArea()
               
               VStack {
                   TextField("City Name", text: $searchText)
                       .padding()
                       .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                       .onChange(of: searchText) { newValue in
                           datas.filterBy(name: newValue)
                           print(datas.filteredCities.count)
                       }
                   Spacer()
                   VStack {
                       if datas.filteredCities.count > 0 && datas.filteredCities.count < 40 {
                           List {
                               ForEach(datas.filteredCities) { city in
                                   Button {
                                       withAnimation(.easeIn(duration: 0.4)) {
                                           weatherFetcher.city = city
                                           nav.showCityChoose.toggle()
                                           weatherFetcher.weather = nil
                                       }
//                                       Task {
//                                           await weatherFetcher.fetchDaily()
//                                       }
                                   } label: {
                                       HStack {
                                           Text(city.country)
                                           Text(city.name)
                                       }
                                       .lineLimit(1)
                                       .listRowBackground(Color.clear)
                                   }
                               }
                           }
                           .scrollContentBackground(.hidden)
                       } else {
                           Text("No Results!")
                           Spacer()
                       }
                   }
                   .cornerRadius(16)
               }
               .padding()
           } 
       }
}

struct CityChoose_Previews: PreviewProvider {
    static var previews: some View {
        CityChoose()
    }
}
