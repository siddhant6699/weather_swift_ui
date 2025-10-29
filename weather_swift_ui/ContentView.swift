//
//  ContentView.swift
//  weather_swift_ui
//
//  Created by Siddhant Chouhan on 26/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundGradientView(isNight: isNight)
            //Heading stack
            VStack {
                CityTextView(cityName: "Cupertino, CA")
                
                CityWeatherIconView(iconText: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: 76)
                //Upcoming days preview
                HStack(spacing: 16){
                    WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 72)
                    WeatherDayView(dayOfWeek: "WED", imageName: "sun.max.fill", temperature: 76)
                    WeatherDayView(dayOfWeek: "THU", imageName: "sun.max.fill", temperature: 76)
                    WeatherDayView(dayOfWeek: "FRI", imageName: "cloud.sun.fill", temperature: 72)
                    WeatherDayView(dayOfWeek: "SAT", imageName: "sunset.fill", temperature: 60)
                }
                Spacer()
                //Button view
                Button{
                    isNight.toggle()
                } label: {
                    WeatherButton(
                        buttonText: "Change Day Time",
                        buttonTextColor: Color.blue,
                        buttonBackgroundColor: Color.white)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
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
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size: 30, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundGradientView: View {
    var isNight: Bool
    
    var body: some View {
//        Custom gradient approach
//        LinearGradient(gradient: Gradient(
//                        colors: [isNight ? .black : .blue,
//                                 isNight ? .gray : Color("lightBlue")]),
//                        startPoint: .topLeading,
//                        endPoint: .bottomTrailing)
//        .ignoresSafeArea()
        ContainerRelativeShape()
            .fill(isNight ? Color.black.gradient : Color.blue.gradient)
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
