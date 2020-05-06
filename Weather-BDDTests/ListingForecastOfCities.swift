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
                        
                        // Since we will be using a state-based architecture
                        var appState = AppState()
                        
                        // Mock data to be used by our provider
                        let sfoForecast = Forecast(cityName: "San Francisco", currentForecast: "Sunny",
                                                   currentTemp: 20.0, minTemp: 15.0, maxTemp: 25.0)
                        let poaForecast = Forecast(cityName: "Porto Alegre", currentForecast: "Cloudy",
                                                   currentTemp: 15.0, minTemp: 10.0, maxTemp: 20.0)
                        
                        let forecastProvider = MockForecastProvider(cities: [sfoForecast, poaForecast])
                        
                        let loadInteractor = CityLoadingInteractor(loadingService: forecastProvider)
                        
                        
                        context("""
                                WHEN    loading finishes successfully
                                """) {
                                    
                                    it( """
                                        THEN    there should be two cities loaded, SFO and POA
                                        AND     the cities should be in alphabetic order
                                        AND     it should be 15º, "Cloudy", with a min-max of 10º and 20º
                                        AND     it should be 20º, "Sunny", with a min-max of 15º and 25º
                                        """) {
                                        
                                    }
                                    
                        }
            }
            
        }
    }
}
