//
//  DetailViewModel.swift
//  App
//
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var forecastItem: ForecastItem
    
    init(forecastItem: ForecastItem) {
        self.forecastItem = forecastItem
    }
}
