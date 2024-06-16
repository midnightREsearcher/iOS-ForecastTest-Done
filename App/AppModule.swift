//
//  AppModule.swift
//  App
//
//

import Global

public class AppModule: Module {
    public static var shared = AppModule()
    private init() {
        // Singleton
    }
    
    public func registerServices() {
        if isDemoMode() {
            GlobalContainer.defaultContainer.register(ForecastNetworkService.self) { _ in ForecastNetworkServiceMock() }
        } else {
            GlobalContainer.defaultContainer.register(ForecastNetworkService.self) { _ in ForecastNetworkServiceImpl() }
        }
        
        GlobalContainer.defaultContainer.register(ForecastService.self) { resolver in
            ForecastServiceImpl(networkService: resolver.resolve(ForecastNetworkService.self)!)
        }
    }
    
    private func isDemoMode() -> Bool {
        return false
    }
}
