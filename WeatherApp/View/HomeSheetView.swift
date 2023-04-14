//
//  HomeSheetView.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import SwiftUI
import WeatherKit

struct HomeSheetView: View {
    
    var weather: Weather?
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .top) {
                MyCustomShape()
                    .foregroundStyle(LinearGradient(colors: [Color.periwinkle, Color.saphhire], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .overlay {
                        MyCustomShape()
                            .fill(
                                .shadow(.inner(color: Color(red: 197/255, green: 197/255, blue: 197/255),radius: 3, x:3, y: 3))
                                .shadow(.inner(color: .white, radius: 3, x: -3, y: -3))
                            )
                            .opacity(0.2)
                    }
                    
                Circle()
                    .frame(width: 70)
                    .foregroundStyle(LinearGradient(colors: [Color.periwinkle, Color.saphhire], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .padding(4)
                    .background(Color.white, in: Circle())
                    .padding(.top, -35)
                    .blendMode(.destinationOut)
            }
            .compositingGroup()
            .ignoresSafeArea()
            
            VStack {
                Button {
                    // Expand Sheet
                    
                } label: {
                    Circle()
                        .foregroundColor(.clear)
                        .frame(width: 65)
                        .background(LinearGradient(colors: [Color.periwinkle.opacity(0.6), Color.saphhire.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    , in: Circle())
                        .overlay {
                            Circle()
                                .fill(
                                    LinearGradient(colors: [Color.white.opacity(0.35), Color.saphhire.opacity(0.1)], startPoint: .top, endPoint: .bottom)
                                )
//                                        .opacity(0.2)
                        }
                        .overlay {
                            Image.arrowUp
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding(4)
                        .padding(.top, -35)
                }
                
                GeometryReader { geo in
                    ScrollView(.vertical, showsIndicators: false) {
                        SunsetView(weather: weather)
                    }
                    .padding(.top)
                }
            }
        }
    }
}

struct HomeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSheetView(weather: nil)
    }
}
