//
//  ForecastService.swift
//  App
//
//

import Combine

protocol ForecastService {
    var items: CurrentValueSubject<ForecastItems, Never> { get }
    func fetchForecast()
}

class ForecastServiceImpl: ForecastService {
    var items = CurrentValueSubject<ForecastItems, Never>([])
    private var cancellables = Set<AnyCancellable>()

    private let networkService: ForecastNetworkService
    
    init(networkService: ForecastNetworkService) {
        self.networkService = networkService
        fetchForecast()
    }
    
    func fetchForecast() {
        networkService.getForecast()
            .map { $0.map { ForecastItem(dto: $0) } }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching forecast: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] forecastItems in
                self?.items.send(forecastItems)
            })
            .store(in: &cancellables)
    }
}

class ForecastNetworkServiceMock: ForecastNetworkService {
    func getForecast() -> AnyPublisher<[ForecastItemDTO], Error> {
        let staticData: [ForecastItemDTO] = [
            ForecastItemDTO(day: "Monday", description: "Sunny", sunrise: 1623049200, sunset: 1623096000, chanceRain: 0.1, high: 28, low: 18, type: "sunny"),
            ForecastItemDTO(day: "Tuesday", description: "Cloudy", sunrise: 1623135600, sunset: 1623182400, chanceRain: 0.4, high: 24, low: 16, type: "cloudy")
        ]
        return Just(staticData)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
