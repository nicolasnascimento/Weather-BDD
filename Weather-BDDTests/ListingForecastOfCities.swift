//
//  ListingForecastOfCities.swift
//  Weather-BDDTests
//
//  Created by Nicolas Nascimento on 04/05/20.
//  Copyright © 2020 Nicolas Nascimento. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Combine
@testable import Weather_BDD

final class ListingForecastOfCities: QuickSpec {
    override func spec() {
        
        describe("Listing forecast of cities") {
            
            context("""
                    GIVEN   the target cities are San Francisco (SFO) and Porto Alegre (POA)
                    AND     in SFO, it is 20º, "Sunny", with a min-max of 15º and 25º
                    AND     in POA, it is 15º, "Cloudy", with a min-max of 10º and 20º
                    AND     the App has started to load the forecast for the target cities
                    """) {
                        
                        // Mock forecast
                        let sfoForecast = Forecast(cityName: "San Francisco", currentForecast: "Sunny",
                                                   currentTemp: 20.0, minTemp: 15.0, maxTemp: 25.0)
                        let poaForecast = Forecast(cityName: "Porto Alegre", currentForecast: "Cloudy",
                                                   currentTemp: 15.0, minTemp: 10.0, maxTemp: 20.0)
                        let forecasts = [sfoForecast, poaForecast]
                        
                        // Mock Provider
                        let provider = MockForecastProvider(forecasts: forecasts)
                        
                        // Interactor
                        let interactor = ForecastLoadingInteractor(forecastProvider: provider)
                        
                        // Since we will be using a state-based architecture, create the initial state
                        var appState = AppState(status: .loadingForecast)
                        
                        // Ensure app has started to load the forecast for the target cities
                        let interactorPB = interactor.perform(action: .load, in: appState)
                        
                        context("""
                                WHEN    loading finishes successfully
                                """) {
                                    
                                    // Use the sink operator to complete load
                                    _ = interactorPB
                                        .sink(receiveCompletion: {
                                            if case .failure(let error) = $0 {
                                                fail("Op. should not fail: \(error)")
                                            }
                                        }) {
                                            appState.forecasts = $0
                                            appState.status = .loadedForecasts
                                        }
                                    
                                    it( """
                                        THEN    there should be two cities loaded, SFO and POA
                                        AND     the cities should be in alphabetic order
                                        AND     it should be 15º, "Cloudy", with a min-max of 10º and 20º
                                        AND     it should be 20º, "Sunny", with a min-max of 15º and 25º
                                        """) {
                                            
                                            // Check state
                                            expect(appState.status).to(equal(.loadedForecasts))
                                            
                                            // Check number of cities
                                            expect(appState.forecasts.count).toEventually(equal(2))
                                            
                                            // Check all parameters are correct, using the equality comparision
                                            expect(appState.forecasts).toEventually(contain([sfoForecast, poaForecast]))
                                            
                                            // Check if order of elements is correct
                                            expect(appState.forecasts).toEventually(equal(forecasts.sorted{ $0.cityName < $1.cityName }))
                                    }
                        }
            }
        }
    }
}

struct MockForecastProvider: ForecastProvider {
    var forecasts: [Forecast]
    
    func getForecasts() -> AnyPublisher<[Forecast], Error> {
        Future<[Forecast], Error> { $0(.success(self.forecasts)) }.eraseToAnyPublisher()
    }
}

