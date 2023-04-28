//
//  HomeSheetView.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 4/1/23.
//

import SwiftUI
import WeatherKit

struct HomeSheetView: View {
    
    @ObservedObject var nav = NavigationManager.shared
    @ObservedObject var weatherFetcher = WeatherFetcher.shared
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .top) {
                if !nav.isSheetExpanded {
                    SheetShape()
                        .foregroundStyle(LinearGradient(colors: [Color.periwinkle, Color.saphhire], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .overlay {
                            SheetShape()
                                .fill(
                                    LinearGradient(colors: [Color.white.opacity(0.35), Color.clear], startPoint: .top, endPoint: .bottom)
                                    .shadow(.inner(color: Color(red: 197/255, green: 197/255, blue: 197/255),radius: 3, x:3, y: 3))
                                    .shadow(.inner(color: .white, radius: 3, x: -3, y: -3))
                                )
                        }
                } else {
                    SheetShape2()
                        .foregroundStyle(LinearGradient(colors: [Color.periwinkle, Color.saphhire], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .overlay {
                            SheetShape2()
                                .fill(
                                    LinearGradient(colors: [Color.white.opacity(0.35), Color.clear], startPoint: .top, endPoint: .bottom)
                                    .shadow(.inner(color: Color(red: 197/255, green: 197/255, blue: 197/255),radius: 3, x:3, y: 3))
                                    .shadow(.inner(color: .white, radius: 3, x: -3, y: -3))
                                )
                        }
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
                    withAnimation(.easeOut(duration: 0.4)) {
                        nav.isSheetExpanded.toggle()
                    }
                } label: {
                    Circle()
                        .foregroundColor(.clear)
                        .frame(width: 65)
                        .background(LinearGradient(colors: [Color.periwinkle.opacity(0.6), Color.saphhire.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    , in: Circle())
                        .overlay {
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(colors: [Color.periwinkle, Color.saphhire], startPoint: .top, endPoint: .bottom)
                                    )
                                Circle()
                                    .fill(
                                        .shadow(.inner(color: .white, radius: 1, x: -0.8, y: -2.5))
                                        .opacity(0.4)
                                    )
                            }
                            
//
                        }
                        .overlay {
                            Image(systemName: nav.isSheetExpanded ? SF.arrowDown : SF.arrowUp)
                                .font(.title3)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                        .padding(4)
                        .padding(.top, -35)
                }
                if !nav.isSheetExpanded {
                    ScrollView(.vertical, showsIndicators: false) {
                        SunsetCellView(dailyWeatherList: $weatherFetcher.dailyTemperatures)
                        UVIndexCellView(dailyWeatherList: $weatherFetcher.dailyTemperatures)
                    }
                    .padding(.top)
                } else {
                    VStack(spacing: 0) {
                        ArcSliderView()
                        Rectangle()
                            .foregroundColor(.clear)
                            .overlay {
                                SummaryView()
                            }
                        Rectangle()
                            .foregroundColor(.clear)
                            .overlay {
                                MapView()
                            }
                    }
                }
            }
        }
    }
}

struct HomeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        @ObservedObject var nav = NavigationManager.shared
        HomeSheetView()
            .onAppear { nav.isSheetExpanded = true }
    }
}
