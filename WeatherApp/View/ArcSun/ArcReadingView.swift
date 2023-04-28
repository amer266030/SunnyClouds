//
//  ArcScaleView.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 27/04/2023.
//

import SwiftUI

struct ArcReadingView: View {
    
    @ObservedObject var weatherFetcher = WeatherFetcher.shared
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Circle()
                .trim(from: 0.55, to: 0.95)
                .foregroundColor(Color.clear)
                .overlay {
                    ZStack {
                        scaleLine(at: 2)
                        
                        // MARK: - Temperature Marking
                        ZStack {
                            HStack {
                                VStack {
                                    Image.sunHaze
                                        .font(.title2)
                                    Text("\(weatherFetcher.dailyTemperatures.first?.sunrise?.formatted(date: .omitted, time: .shortened) ?? "?")")
                                    Text("Sun rise")
                                }
                                Spacer()
                                VStack {
                                    Image.sunHaze
                                        .font(.title2)
                                    Text("\(weatherFetcher.dailyTemperatures.first?.sunset?.formatted(date: .omitted, time: .shortened) ?? "?")")
                                    Text("Sun set")
                                }
                            }
                        }
                        .font(.subheadline)
                        .fontWidth(.compressed)
                        .foregroundColor(Color.white)
                    }
                    .padding()
                }
        }
    }
    
    func scaleLine(at line: Int) -> some View {
        VStack {
            Image("WeatherIcon - 2-22")
                .resizable()
                .frame(width: 40, height: 40)
            Spacer()
        }
        .rotationEffect(.degrees(Double(line) * 30 - 90))
    }
    
}

struct ArcReadingView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.saphhire
            ArcReadingView()
        }
    }
}
