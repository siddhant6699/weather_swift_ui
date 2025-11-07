//
//  weather_swift_uiApp.swift
//  weather_swift_ui
//
//  Created by Siddhant Chouhan on 26/10/25.
//

import SwiftUI

@main
struct weather_swift_uiApp: App {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            WeatherView().environmentObject(locationManager)
        }
    }
}
