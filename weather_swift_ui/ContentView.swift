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
            LinearGradient(gradient: Gradient(colors: [.blue, Color("lightBlue")]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            //Heading stack
            VStack {
                Text("Cupertino, CA")
                    .font(.system(size: 32, weight: .medium, design: .monospaced))
                    .foregroundColor(.white)
                    .padding()
                //Icon stack
                VStack(spacing: 8) {
                    Image(systemName: "cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 170, height: 150)
                //Temperature
                    Text("76°")
                        .font(.system(size: 65, weight: .medium, design: .monospaced))
                        .foregroundColor(.white)
                }
                .padding(.bottom, 40)
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
                    Text("Change Day Time")
                        .frame(width: 280, height: 50)
                        .background(Color.white)
                        .font(.system(size: 20,weight: .bold, design: .monospaced))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
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
