//
//  OpenWeatherForecastProvider.swift
//  Weather-BDD
//
//  Created by Nicolas Nascimento on 08/05/20.
//  Copyright © 2020 Nicolas Nascimento. All rights reserved.
//

import Foundation
import Combine

protocol SessionProvider {
    func data(for url: URL) -> AnyPublisher<Data, Error>
}

struct OpenWeatherForecastProvider {
    var sessionProvider: SessionProvider = URLSession.shared
    var apiKey: String
    var cityNames: [String]
}

extension URLSession: SessionProvider {
    func data(for url: URL) -> AnyPublisher<Data, Error> {
        dataTaskPublisher(for: url)
            .map{ $0.data }
            .mapError{ $0 as Error }
            .eraseToAnyPublisher()
    }
}


extension Forecast {
    init(_ response: OpenWeatherForecastProvider.Response) {
        self.cityName = response.name ?? "No Name"
        self.currentForecast =  response.weather?.first?.main ?? "No Temp"
        self.currentTemp = (response.main?.temp ?? 0.0) - 273.15
        self.minTemp = (response.main?.tempMin ?? 0.0) - 273.15
        self.maxTemp = (response.main?.tempMax ?? 0.0) - 273.15
    }
}

extension OpenWeatherForecastProvider: ForecastProvider {
    func getForecasts() -> AnyPublisher<[Forecast], Error> {
        if cityNames.isEmpty {
            return Fail<[Forecast], Error>(error: Self.Errors.noCityNamesProvided).eraseToAnyPublisher()
        }
        return _getForecasts()
    }
    
    private func _getForecasts(at index: Int = 0) -> AnyPublisher<[Forecast], Error> {
        
        // Build URL
        // Example: api.openweathermap.org/data/2.5/weather?q=London&appid=YOUR_API_KEY
        let baseUrlString = "api.openweathermap.org/data/2.5/weather"
        guard var components = URLComponents(string: baseUrlString) else { fatalError() }
        components.queryItems = [URLQueryItem(name: "q", value: cityNames[index]),
                                 URLQueryItem(name: "appid", value: apiKey)]
        guard let url = components.url else { fatalError() }
        
        // Perform Query
        let publisherAtIndex = sessionProvider
            .data(for: url)
            .decode(type: Response.self, decoder: JSONDecoder())
            .map{ [Forecast($0)] }
            .eraseToAnyPublisher()
        
        // If we're the latest query, finish
        if index + 1 == cityNames.count {
            return publisherAtIndex
        
        // Else merge results with the next index's result
        } else {
            return publisherAtIndex
                .combineLatest(self._getForecasts(at: index + 1)) { $0 + $1 }
                .eraseToAnyPublisher()
        }
    }
    
    // Generated at: - https://app.quicktype.io
    struct Response: Codable {
        struct Weather: Codable {
            let main: String
        }
        var weather: [Weather]?
        struct Main: Codable {
            var temp: Double?
            var tempMin: Double?
            var tempMax: Double?
            
            enum CodingKeys: String, CodingKey {
                case temp
                case tempMin = "temp_min"
                case tempMax = "temp_max"
            }
        }
        var main: Main?
        var name: String?
    }
    
    enum Errors: Error {
        case unknown
        case noCityNamesProvided
        case invalidURL
    }
}




