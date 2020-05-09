//
//  OpenWeatherForecastProviderTests.swift
//  Weather-BDDTests
//
//  Created by Nicolas Nascimento on 08/05/20.
//  Copyright © 2020 Nicolas Nascimento. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Combine
@testable import Weather_BDD

final class OpenWeatherForecastProviderTests: QuickSpec {
    
    override func spec() {
        describe("OpenWeatherForecastProvider") {
            context("performing a successfull request") {
                it("should decode Forecast objects apropriately") {
                    // Arrange
                    let apiKey = "YOUR_API_KEY"
                    let cityName = "London"
                    let sessionProvider = MockSessionProvider()
                    let provider: ForecastProvider = OpenWeatherForecastProvider(sessionProvider: sessionProvider,
                                                                                 apiKey: apiKey,
                                                                                 cityNames: [cityName])
                    var forecasts: [Forecast] = []
                    
                    // Act
                    _ = provider
                        .getForecasts()
                        .sink(receiveCompletion: {
                            if case .failure(let error) = $0 {
                                fail("Op should not fail \(error)")
                            }
                        }) { forecasts = $0 }
                        
                    // Assert
                    let expectedForecast = Forecast(cityName: "London", currentForecast: "Drizzle",
                                                    currentTemp: 7.17, minTemp: 6.00, maxTemp: 8.00)
                    expect(forecasts).toEventually(equal([expectedForecast]))
                }
            }
        }
    }
}

struct MockSessionProvider: SessionProvider {
    
    func data(for url: URL) -> AnyPublisher<Data, Error> {
        Future<Data, Error> { $0(.success(self.sampleResponse.data(using: .utf8)!)) }.eraseToAnyPublisher()
    }
    
    private let sampleResponse = "{\"coord\":{\"lon\":-0.13,\"lat\":51.51},\"weather\":[{\"id\":300,\"main\":\"Drizzle\",\"description\":\"light intensity drizzle\",\"icon\":\"09d\"}],\"base\":\"stations\",\"main\":{\"temp\":280.32,\"pressure\":1012,\"humidity\":81,\"temp_min\":279.15,\"temp_max\":281.15},\"visibility\":10000,\"wind\":{\"speed\":4.1,\"deg\":80},\"clouds\":{\"all\":90},\"dt\":1485789600,\"sys\":{\"type\":1,\"id\":5091,\"message\":0.0103,\"country\":\"GB\",\"sunrise\":1485762037,\"sunset\":1485794875},\"id\":2643743,\"name\":\"London\",\"cod\":200}"
}

