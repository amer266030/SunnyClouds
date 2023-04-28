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
    @StateObject var weatherFetcher = WeatherFetcher.shared
    @ObservedObject var nav = NavigationManager.shared
    
    var timeTabs = ["Daily", "Weekly"]
    @State private var selectedTab = "Daily"
    
    var body: some View {
        ZStack(alignment: .top) {
            ContainerRelativeShape()
                .fill(LinearGradient(colors: [Color.periwinkle, Color.saphhire], startPoint: .leading, endPoint: .trailing))
                .overlay(LinearGradient(colors: [Color.white.opacity(0.25), Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                if let weather = weatherFetcher.weather {
                    VStack(spacing: 24) {
                        
                        DynamicStack {
                            // MARK: - City Selection
                            VStack(alignment: nav.isSheetExpanded ? .leading : .center, spacing: 8) {
                                Button {
                                    nav.showCityChoose.toggle()
                                } label: {
                                    Text("\(weatherFetcher.city.name)")
                                        .font(.largeTitle)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                }

                                HStack {
                                    Image.locationPin
                                        .opacity(0.5)
                                    
                                    Text("\(weatherFetcher.city.country)")
                                }
                            }
                            .padding(.horizontal)
                            
                            // MARK: - Large Icon
                            HStack {
                                weatherFetcher.img(fromSF: weather.currentWeather.symbolName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                                
                                Text("\(weather.currentWeather.temperature.value.rounded().formatted())ºC")
                                    .font(.system(size: 75))
                                    .frame(maxWidth: .infinity)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                            }
                            .padding(.horizontal, 32)
                        }
                        
                        if !nav.isSheetExpanded {
                            Text("\(weather.currentWeather.condition.description) - H:\(weatherFetcher.dailyTemperatures.first?.max.rounded().formatted() ?? "")º    L:\(weatherFetcher.dailyTemperatures.first?.min.rounded().formatted() ?? "")º")
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
                            if selectedTab == "Daily" {
                                HourlyForecastView(hourWeatherList: $weatherFetcher.hourTemperatures)
                            } else if selectedTab == "Weekly" {
                                DailyForecastView(dailyWeatherList: $weatherFetcher.dailyTemperatures)
                            }
                        }
                        
                        // MARK: - Sheet View
                        HomeSheetView()
                            .padding(.top)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
