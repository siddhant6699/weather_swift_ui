//
//  WeatherModel.swift
//  weather_swift_ui
//
//  Created by Siddhant Chouhan on 31/10/25.
//

import Foundation
import SwiftUI

nonisolated struct WeatherModel: Codable {
    let location: LocationModel
    let current: CurrentModel
    let forecast: ForecastdayModdel
}

struct LocationModel: Codable {
    let name: String
    let region: String
    let country: String
}

struct CurrentModel: Codable {
    let tempC: Double
    let condition: ConditionModel
}

struct ForecastdayModdel: Codable {
    let forecastday: [ForecastModel]
}

struct ForecastModel: Codable, Identifiable {
    var id: String { date } // Use date as unique identifier
    let date: String
    let day: DayModel
}

struct DayModel: Codable {
    let maxtempC, mintempC: Double
    let condition: ConditionModel
}

struct ConditionModel: Codable {
    let text, icon: String
}

enum WeatherCondition: String {
    case sunny = "sunny"
    case clear = "clear"
    case partlyCloudy = "partly cloudy"
    case cloudy = "cloudy"
    case overcast = "overcast"
    case mist = "mist"
    case patchyRain = "patchy rain possible"
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case heavyRain = "heavy rain"
    case thunder = "thundery outbreaks possible"
    case snow = "snow"
    case unknown
    
    var sfSymbol: String {
        switch self {
        case .sunny, .clear:
            return "sun.max.fill"
        case .partlyCloudy:
            return "cloud.sun.fill"
        case .cloudy, .overcast:
            return "cloud.fill"
        case .mist:
            return "cloud.fog.fill"
        case .patchyRain, .lightRain, .moderateRain:
            return "cloud.rain.fill"
        case .heavyRain:
            return "cloud.heavyrain.fill"
        case .thunder:
            return "cloud.bolt.rain.fill"
        case .snow:
            return "snowflake"
        case .unknown:
            return "questionmark.circle.fill"
        }
    }
    
    init(conditionText: String) {
        // Normalize by trimming spaces and converting to lowercase
        let normalized = conditionText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        self = WeatherCondition(rawValue: normalized) ?? .unknown
    }
}

extension ConditionModel {
    var sfSymbol: String {
        let condition = WeatherCondition(conditionText: text)
        return condition.sfSymbol
    }
}

extension ForecastModel {
    var dayOfWeek: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"  // Format of your API date string
        guard let dateObject = inputFormatter.date(from: date) else { return "" }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEE"        // Gives short day like Mon, Tue, Wed
        return outputFormatter.string(from: dateObject).uppercased()
    }
}

enum TimeOfDay {
    case morning
    case afternoon
    case evening
    case night
    
    static func current() -> TimeOfDay {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 5..<12:
            return .morning
        case 12..<16:
            return .afternoon
        case 16..<19:
            return .evening
        default:
            return .night
        }
    }
}

extension TimeOfDay {
    var backgroundGradient: LinearGradient {
        switch self {
        case .morning:
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.35, green: 0.70, blue: 0.95),
                    Color(red: 0.70, green: 0.85, blue: 0.95)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        case .afternoon:
            return LinearGradient(
                colors: [Color.yellow.opacity(0.7), Color.orange, Color.red.opacity(0.8)],
                startPoint: .top,
                endPoint: .bottom
            )
        case .evening:
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 1.0, green: 0.6, blue: 0.5),
                    Color(red: 1.0, green: 0.4, blue: 0.6),
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .night:
            return LinearGradient(
                colors: [Color.black, Color.gray],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

