//
//  infoCardView.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 18/05/2023.
//

import SwiftUI

struct InfoCardView: View {
    var img: Image
    var title: String
    var reading: String
    
    var body: some View {
        VStack {
            Text(title)
            img
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
            Text(reading)
                .bold()
        }
        .font(.caption2)
        .frame(maxWidth: .infinity)
    }
}
