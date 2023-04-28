//
//  UVView.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 27/04/2023.
//

import SwiftUI

struct UVIndexCellView: View {
    @Binding var dailyWeatherList: [DailyTemperature]
    
    var body: some View {
        HStack(spacing: 32) {
            Image.sunMin
                .font(.largeTitle)
                .bold()
            
            VStack(alignment: .leading) {
                Text("UV Index")
                Text("\(dailyWeatherList.first?.uvIndex ?? 0)")
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

struct UVIndexCellView_Previews: PreviewProvider {
    static var previews: some View {
        UVIndexCellView(dailyWeatherList: .constant([]))
    }
}
