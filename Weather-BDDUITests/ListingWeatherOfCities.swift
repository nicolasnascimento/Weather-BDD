//
//  ListingWeatherOfCities.swift
//  Weather-BDDUITests
//
//  Created by Nicolas Nascimento on 04/05/20.
//  Copyright © 2020 Nicolas Nascimento. All rights reserved.
//

import Foundation
import Quick
import Nimble
import XCTest
@testable import Weather_BDD

final class ListingWeatherOfCities: QuickSpec {

    override func spec() {
        describe("Listing forecast of cities - UI") {
            
            context("""
                    GIVEN   the target cities are San Francisco (SFO) and Porto Alegre (POA)
                    AND     in SFO, it is 20º, "Sunny", with a min-max of 15º and 25º
                    AND     in POA, it is 15º, "Cloudy", with a min-max of 10º and 20º
                    AND     the App has started to load the forecast for the target cities
                    """) {
                        
                        context("""
                                WHEN    loading finishes successfully
                                """) {
                                    
                                    it( """
                                        THEN    there should be two cities loaded, SFO and POA
                                        AND     the cities should be in alphabetic order
                                        AND     in POA it should be 15º, "Cloudy", with a min-max of 10º and 20º
                                        AND     In SFO it should be 20º, "Sunny", with a min-max of 15º and 25º
                                        """) {
                                            let app = XCUIApplication()
                                            app.launchArguments.append("--UITESTING")
                                            app.launch()
                                            
                                            expect(app.tables.count).toEventually(equal(1))
                                            expect(app.cells.allElementsBoundByIndex.count).toEventually(equal(2))
                                            
                                            let firstCell = app.cells.allElementsBoundByIndex.first
                                            expect(firstCell?.staticTexts["San Francisco - 20º"].exists).toEventually(beTrue())
                                            expect(firstCell?.staticTexts["15º - 25º"].exists).toEventually(beTrue())
                                            expect(firstCell?.images["sun.max.fill"].exists).toEventually(beTrue())
                                            
                                            let secondCell = app.cells.allElementsBoundByIndex.last
                                            expect(secondCell?.staticTexts["Porto Alegre - 15º"].exists).toEventually(beTrue())
                                            expect(secondCell?.staticTexts["10º - 20º"].exists).toEventually(beTrue())
                                            expect(secondCell?.images["cloud.fill"].exists).toEventually(beTrue())
                                    }
                        }
            }
        }
    }
}

