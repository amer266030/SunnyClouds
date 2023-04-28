//
//  SummaryView.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 27/04/2023.
//

import SwiftUI

struct SummaryView: View {
    
    @ObservedObject var weatherFetcher = WeatherFetcher.shared
    
    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(LinearGradient(colors: [Color.periwinkle, Color.saphhire], startPoint: .top, endPoint: .bottom))
                .opacity(0.3)
            VStack(spacing: 24) {
                HStack {
                    Text("Summary")
                        .font(.title3)
                    Spacer()
                    Text("Oct, 10")
                }
                
                Grid(verticalSpacing: 16) {
                    GridRow {
                        VStack {
                            Image.thermo
                            Text("min/max")
                                .fontWeight(.light)
                            Text("\(weatherFetcher.dailyTemperatures.first?.min.rounded().formatted() ?? "?")/\(weatherFetcher.dailyTemperatures.first?.max.rounded().formatted() ?? "?")")
                                .bold()
                        }
                        Spacer()
                        VStack {
                            Image.cloud
                            Text("Cloud")
                                .fontWeight(.light)
                            Text("\( (weatherFetcher.hourTemperatures.first?.cloudCover ?? 0) * 100 .rounded(), specifier: "%0.f")%")
                                .bold()
                        }
                        Spacer()
                        VStack {
                            Image.wind
                            Text("\(weatherFetcher.weather?.currentWeather.condition.description ?? "Haze")")
                                .fontWeight(.light)
                            Text("\(weatherFetcher.dailyTemperatures.first?.wind ?? 0, specifier: "%0.f") km/h")
                                .bold()
                        }
                    }
                    GridRow {
                        VStack {
                            Image.sunHaze
                            Text("Sun rise")
                                .fontWeight(.light)
                            Text("\(weatherFetcher.dailyTemperatures.first?.sunrise?.formatted(date: .omitted, time: .shortened) ?? "?")")
                                .bold()
                        }
                        Spacer()
                        VStack {
                            Image.sunHaze
                            Text("Sun set")
                                .fontWeight(.light)
                            Text("\(weatherFetcher.dailyTemperatures.first?.sunset?.formatted(date: .omitted, time: .shortened) ?? "?")")
                                .bold()
                        }
                        Spacer()
                        VStack {
                            Image.humidity
                            Text("Humidity")
                                .fontWeight(.light)
                            Text("\( (weatherFetcher.weather?.currentWeather.humidity ?? 0) * 100 .rounded(), specifier: "%0.f") %")
                                .bold()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .font(.callout)
            .foregroundColor(.white)
            .fontDesign(.rounded)
            .padding()
        }
        .cornerRadius(16)
        .padding()
    }
}

//struct SummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            ContainerRelativeShape()
//                .fill(Color.saphhire.gradient)
//            SummaryView()
//        }
//
//    }
//}
