//
//  SunsetView.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import SwiftUI
import WeatherKit

struct SunsetCellView: View {
    
    @Binding var dailyWeatherList: [DailyTemperature]
    
    var body: some View {
        HStack(spacing: 32) {
            Image.sunHaze
                .font(.largeTitle)
                .bold()
            
            VStack(alignment: .leading) {
                Text("Sunset")
                Text("\(dailyWeatherList.first?.sunset?.formatted(date: .omitted, time: .shortened) ?? "")")
                    .bold()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
            }
            
            VStack(alignment: .leading) {
                Text("Sunrise")
                Text("\(dailyWeatherList.first?.sunrise?.formatted(date: .omitted, time: .shortened) ?? "")")
                    .bold()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            LinearGradient(colors: [Color.white.opacity(0.5), Color.saphhire.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                        , in: RoundedRectangle(cornerRadius: 16, style: .continuous)
        )
        .padding(.horizontal, 40)
    }
}

struct SunsetCellView_Previews: PreviewProvider {
    static var previews: some View {
        SunsetCellView(dailyWeatherList: .constant([]))
    }
}
