//
//  CityChoose.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import SwiftUI

import SwiftUI

struct CityChoose: View {
    @ObservedObject var datas = ReadData()
    @State private var searchText = ""
           
       var body: some View {
           ZStack {
               ContainerRelativeShape()
                   .fill(Color.periwinkle.gradient)
                   .ignoresSafeArea()
               
               VStack {
                   TextField("City Name", text: $searchText)
                       .padding()
                       .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                       .onChange(of: searchText) { newValue in
                           datas.filterBy(name: newValue)
                       }
                   
                   VStack {
                       if datas.filteredCities.count < 20 {
                           List {
                               ForEach(datas.filteredCities) { city in
                                   HStack {
                                       Text(city.country)
                                       Text(city.name)
                                   }
                                   .lineLimit(1)
                                   .listRowBackground(Color.clear)
                               }
                           }
                           .scrollContentBackground(.hidden)
                       }
                   }
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
