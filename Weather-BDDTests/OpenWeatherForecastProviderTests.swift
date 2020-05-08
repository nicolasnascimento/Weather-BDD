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
                    let sessionProvider = MockSessionProvider()
                    let provider: ForecastProvider = OpenWeatherForecastProvider(sessionProvider: sessionProvider)
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


