//
//  WeatherButton.swift
//  weather_swift_ui
//
//  Created by Siddhant Chouhan on 28/10/25.
//

import SwiftUI

struct WeatherButton: View {
    var buttonText: String
    var buttonTextColor: Color
    var buttonBackgroundColor: Color
    
    var body: some View {
        Text(buttonText)
            .frame(width: 280, height: 50)
            .background(buttonBackgroundColor)
            .foregroundStyle(buttonTextColor)
            .font(.system(size: 20,weight: .bold, design: .monospaced))
            .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
