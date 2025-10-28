//
//  ContentView.swift
//  weather_swift_ui
//
//  Created by Siddhant Chouhan on 26/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            BackgroundGradientView(topColor: .blue, bottomColor: Color("lightBlue"))
            //Heading stack
            VStack {
                CityTextView(cityName: "Cupertino, CA")
                
                CityWeatherIconView(iconText: "cloud.sun.fill", temperature: 76)
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
                    print("tapped")
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
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size: 30, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundGradientView: View {
    var topColor: Color
    var bottomColor: Color
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
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
