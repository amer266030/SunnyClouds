//
//  DynamicStack.swift
//  WeatherApp
//
//  Created by Amer Alyusuf on 27/04/2023.
//

import SwiftUI

struct DynamicStack<Content: View>: View {
    var horizontalAlignment = HorizontalAlignment.center
    var verticalAlignment = VerticalAlignment.center
    var spacing: CGFloat?
    
    @ObservedObject var nav = NavigationManager.shared
    
    @ViewBuilder var content: () -> Content

    var body: some View {
        Group {
            if nav.isSheetExpanded {
                HStack(
                    alignment: verticalAlignment,
                    spacing: spacing,
                    content: content
                )
            } else {
                VStack(
                    alignment: horizontalAlignment,
                    spacing: spacing,
                    content: content
                )
            }
        }
    }
}
