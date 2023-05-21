//
//  CityChoose.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import SwiftUI
import CoreLocation

struct CityChoose: View {
    @ObservedObject var nav = NavigationManager.shared
    @ObservedObject var weatherFetcher = WeatherFetcher.shared
    @ObservedObject var datas = CityFetcher()
    @State private var searchText = ""
    @State private var countryText = ""
    @ObservedObject var location = LocationManager.shared
           
       var body: some View {
           ZStack {
               ContainerRelativeShape()
                   .fill(Color.periwinkle.gradient)
                   .ignoresSafeArea()
               
               VStack(spacing: 16) {
                   // MARK: - Top Text
                   HStack {
                       Button {
                           nav.showCityChoose.toggle()
                       } label: {
                           Image(systemName: "chevron.left")
                       }
                       Spacer()
                       
                       Text("Select City")
                       
                       Spacer()
                   }
                   .font(.title3)
                   .foregroundColor(.white)
                   .bold()
                   
                   Divider()
                   
                   // MARK: - Current Location
                   if location.currentLocation != nil {
                       VStack(alignment: .leading) {
                           HStack {
                               Button {
                                   if location.cityName != weatherFetcher.city?.name && location.countryName != weatherFetcher.city?.country {
                                       withAnimation(.easeOut(duration: 0.4)) {
                                           weatherFetcher.city = nil
                                           weatherFetcher.weather = nil
                                           nav.showCityChoose.toggle()
                                       }
                                   }
                               } label: {
                                   Label("Current Location: ", systemImage: "mappin.circle.fill")
                               }
                               Text("\(location.countryName), ")
                               Text("\(location.cityName)")
                               Spacer()
                           }
                       }
                       .padding(.leading)
                       .lineLimit(1)
                       .fontWidth(.condensed)
                       .minimumScaleFactor(0.5)
                       .foregroundColor(.white)
                       .frame(maxWidth: .infinity)
                   }

                   // MARK: - Filter Text
                   Grid {
                       // MARK: - Labels
                       GridRow {
                           HStack {
                               Text("COUNTRY")
                                   .padding(.leading)
                               Spacer()
                           }
                               .gridCellColumns(1)
                           HStack {
                               Text("CITY")
                                   .padding(.leading)
                               Spacer()
                           }
                               .gridCellColumns(3)
                       }
                       .foregroundColor(.white)
                       .font(.caption)
                       .fontWidth(.condensed)
                       
                       // MARK: - Text Fields
                       GridRow {
                           TextField("GB", text: $countryText)
                               .padding()
                               .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                               .onChange(of: countryText) { newValue in
                                   datas.filterBy(name: searchText, country: newValue)
                               }
                           .gridCellColumns(1)
                           TextField("London", text: $searchText)
                               .padding()
                               .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                               .onChange(of: searchText) { newValue in
                                   datas.filterBy(name: newValue, country: countryText)
                               }
                           .gridCellColumns(3)
                       }
                       .foregroundColor(.primary)
                   }
                   .padding(.bottom)
                   
                   // MARK: - Result List
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
