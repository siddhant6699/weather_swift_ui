//
//  WeatherModel.swift
//  weather_swift_ui
//
//  Created by Siddhant Chouhan on 31/10/25.
//

import Foundation

nonisolated struct WeatherModel: Codable {
    let current: CurrentModel
    let forecast: ForecastdayModdel
}

struct CurrentModel: Codable {
    let tempC: Double
    let condition: ConditionModel
}

struct ForecastdayModdel: Codable {
    let forecastday: [ForecastModel]
}

struct ForecastModel: Codable {
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
