//
//  HomeView.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 3/31/23.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct HomeView: View {
    
    @StateObject var locationManager = LocationManager()
    @StateObject var weatherFetcher = WeatherFetcher()
    
    var timeTabs = ["Daily", "Weekly"]
    @State private var selectedTab = "Daily"
    
    var body: some View {
        ZStack(alignment: .top) {
            ContainerRelativeShape()
                .fill(LinearGradient(colors: [Color.periwinkle, Color.saphhire], startPoint: .topLeading, endPoint: .bottomTrailing))
                .overlay(LinearGradient(colors: [Color.white.opacity(0.35), Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // MARK: - Data
                if let weather = weatherFetcher.weather {
                    VStack {
                        Text("\(weatherFetcher.city.name)")
                            .font(.largeTitle)
                            .bold()
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        
                        HStack {
                            Image.locationPin
                                .opacity(0.5)
                            
                            Text("\(weatherFetcher.city.country)")
                        }
                        
                        // MARK: - Large Icon
                        HStack {
                            Image.weatherDefault
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                            
                            Text("\(weather.currentWeather.temperature.formatted())")
                                .font(.system(size: 75))
                                .frame(maxWidth: .infinity)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                        }
                        .padding(.top, 24)
                        .padding(.horizontal, 32)
                            
                        Text("\(weather.currentWeather.condition.description) - H:\(weatherFetcher.dailyTemperatures.first?.max.formatted() ?? "") L:\(weatherFetcher.dailyTemperatures.first?.min.formatted() ?? "")")
                            .font(.headline)
                        
                        // MARK: - Tabs
                        HStack {
                            ForEach(timeTabs, id: \.self) { tab in
                                Button {
                                    selectedTab = tab
                                } label: {
                                    Text("\(tab)")
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(selectedTab == tab ? Color.periwinkle : Color.saphhire, in: Capsule())
                                }
                            }
                        }
                        .padding(.horizontal, 80)
                        
                        // MARK: - Horizontal ScrollView
                        HourlyForecastView(hourWeatherList: $weatherFetcher.hourTemperatures)
                        
                        // MARK: - Sheet View
                        HomeSheetView(weather: weatherFetcher.weather)
                    }
                } else {
                    Spacer()
                    ProgressView()
                        .task {
                            await weatherFetcher.fetchDaily()
                        }
                    Spacer()
                }
            }
        }
        .foregroundColor(.white)
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
