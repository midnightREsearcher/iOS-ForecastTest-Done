//
//  ForecastItem.swift
//  App
//
//

import Foundation

struct ForecastItem {
    let day: String
    let description: String
    let sunrise: Int
    let sunset: Int
    let chanceRain: Double
    let high: Int
    let low: Int
    let type: String
}

extension ForecastItem {
    init(dto: ForecastItemDTO) {
        self.day = dto.day
        self.description = dto.description
        self.sunrise = dto.sunrise
        self.sunset = dto.sunset
        self.chanceRain = dto.chanceRain
        self.high = dto.high
        self.low = dto.low
        self.type = dto.type
    }
}

typealias ForecastItems = [ForecastItem]
