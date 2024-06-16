//
//  DetailView.swift
//  App
//
//

import SwiftUI
import GlobalUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        ZStack {

            getBackgroundGradient(for: viewModel.forecastItem.type)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Day \(viewModel.forecastItem.day)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(viewModel.forecastItem.description)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                HStack {
                    VStack {
                        Text("High")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("\(viewModel.forecastItem.high)°C")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Low")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("\(viewModel.forecastItem.low)°C")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    VStack {
                        Text("Sunrise")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(formatTime(seconds: viewModel.forecastItem.sunrise))
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Sunset")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(formatTime(seconds: viewModel.forecastItem.sunset))
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                
                Text("Chance of Rain: \(Int(viewModel.forecastItem.chanceRain * 100))%")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }
    }
    
    func getBackgroundGradient(for weatherType: String) -> LinearGradient {
        switch weatherType {
        case "sunny":
            return LinearGradient(gradient: Gradient(colors: [GlobalColor.sunnyGradientStart, GlobalColor.sunnyGradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
        case "lightning":
            return LinearGradient(gradient: Gradient(colors: [GlobalColor.lightningGradientStart, GlobalColor.lightningGradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
        case "rain":
            return LinearGradient(gradient: Gradient(colors: [GlobalColor.rainGradientStart, GlobalColor.rainGradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
        case "overcast":
            return LinearGradient(gradient: Gradient(colors: [GlobalColor.overcastGradientStart, GlobalColor.overcastGradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
        case "windy":
            return LinearGradient(gradient: Gradient(colors: [GlobalColor.windyGradientStart, GlobalColor.windyGradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
        case "showers":
            return LinearGradient(gradient: Gradient(colors: [GlobalColor.showersGradientStart, GlobalColor.showersGradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
        default:
            return LinearGradient(gradient: Gradient(colors: [GlobalColor.defaultGradientStart, GlobalColor.defaultGradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
    
    func formatTime(seconds: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(seconds))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(forecastItem: ForecastItem(day: "1", description: "Sunny", sunrise: 27420, sunset: 63600, chanceRain: 0.1, high: 15, low: 6, type: "sunny")))
    }
}
