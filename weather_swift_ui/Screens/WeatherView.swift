//
//  ContentView.swift
//  weather_swift_ui
//
//  Created by Siddhant Chouhan on 26/10/25.
//

import SwiftUI
internal import _LocationEssentials

struct WeatherView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        ZStack {
            switch locationManager.state {
            case .idle:
                ProgressView("Fetching weather...")
                
            case .loading:
                ProgressView("Fetching weather...")
                
            case .loaded(let weather):
                LoadedWeathedView(weather: weather)
                
            case .failed(let error):
                VStack {
                    Text("Failed to load weather 😔")
                        .foregroundColor(.red)
                    Text(error)
                        .font(.caption)
                    Button("Retry") {
                        locationManager.requestLocation()
                    }
                    .padding(.top, 8)
                }
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var locationManager = LocationManager()
    WeatherView().environmentObject(locationManager)
}

struct LoadedWeathedView: View {
    var weather: WeatherModel
    
    
    var body: some View{
        BackgroundGradientView()
        //Heading stack
        VStack {
            CityTextView(cityName: "\(weather.location.name), \(weather.location.region.prefix(2).uppercased())")
            
            CityWeatherIconView(iconText: false ? "moon.stars.fill" : weather.current.condition.sfSymbol, temperature: Int(weather.current.tempC))
            //Upcoming days preview
//            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12){
                    ForEach(weather.forecast.forecastday.dropFirst()) { forecasts in
                        WeatherDayView(dayOfWeek: forecasts.dayOfWeek, imageName: forecasts.day.condition.sfSymbol, temperature: Int(forecasts.day.maxtempC))
                            .frame(width: 58, height: 120)
                            .padding(4)
                            .glassEffect(.clear.interactive(true), in: .capsule)
                    }
                }
            
            Spacer()
        }
    }
}

struct WeatherDayView: View {
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack{
            Text(dayOfWeek)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
            //                .foregroundStyle(.indigo)
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            Text("\(temperature)°")
                .font(.system(size: 24, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundGradientView: View {
    var body: some View {
        //        Custom gradient approach
        //        LinearGradient(gradient: Gradient(
        //                        colors: [isNight ? .black : .blue,
        //                                 isNight ? .gray : Color("lightBlue")]),
        //                        startPoint: .topLeading,
        //                        endPoint: .bottomTrailing)
        //        .ignoresSafeArea()
        //        ContainerRelativeShape()
        //            .fill(isNight ? Color.black.gradient : Color.blue.gradient)
        //            .ignoresSafeArea()
        TimeOfDay.current().backgroundGradient
            .ignoresSafeArea()
    }
}

struct CityTextView: View {
    var cityName: String
    
    var body: some View{
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .monospaced))
            .foregroundColor(.white)
            .padding()
    }
}

struct CityWeatherIconView: View {
    var iconText: String
    var temperature: Int
    
    var body: some View{
        VStack(spacing: 8) {
            Image(systemName: iconText)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 170, height: 150)
            Text("\(temperature)°")
                .font(.system(size: 65, weight: .medium, design: .monospaced))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}
