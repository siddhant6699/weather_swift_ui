//
//  NetworkManager.swift
//  weather_swift_ui
//
//  Created by Siddhant Chouhan on 01/11/25.
//

import Foundation


class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.weatherapi.com/v1/"
    
    private init () {}
    
    func fetchWeather(for city: String, completed: @escaping (WeatherModel?, String?) -> Void) {
        let endpoint = baseUrl + "forecast.json?key=ffec9787d11441b2a8354918253110&days=6&q=\(city)"
        print(endpoint)
        guard let url = URL(string: endpoint) else {
            print(endpoint)
            completed(nil, "Invalid request. Please try again later.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(nil, "Please check you internet connection.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from server. Please try again later.")
                return
            }
            
            guard let data = data else {
                completed(nil, "Invalid data reveived from server. Please try again later.")
                return
            }
            
            do {
                let decoader = JSONDecoder()
                decoader.keyDecodingStrategy = .convertFromSnakeCase
                let weather = try decoader.decode(WeatherModel.self, from: data)
                completed(weather, nil)
            } catch {
                completed(nil, "Invalid data reveived from server. Please try again later.")
            }
        }
        
        task.resume()
    }
}

    
    
