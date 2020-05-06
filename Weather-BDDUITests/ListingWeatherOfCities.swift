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
@testable import Weather_BDD

final class ListingWeatherOfCities: QuickSpec {

    override func spec() {
        // MARK: - Scenario 1 - Launching App
               describe(   """
                           GIVEN the App is not open
                           """) {
                               // This basically means we have no pre-requisite!!
                               
                               context("""
                                   WHEN I open the App
                                   """) {
                                       
                                       it( """
                                           THEN    I should be in the HomeScreen
                                           AND     the App should have started to load weather info for my prefered cities
                                           """) {
                                               
                                       }
                                       
                               }
               }
               
               // MARK: - Scenario 2 - Successfully loaded weather
               describe(   """
                           GIVEN   the App is loading weather info for my prefered cities
                           AND     I am in the First Screen
                           AND     I am is connected to the internet
                           AND     My favorite cities are San Francisco, London, São Paulo and Porto Alegre
                           AND     their temperature, and forecast are the following
                           """) {
                               // | City           | Max T. | Min T. | Current T. | Current Forecast |
                               // |----------------|--------|--------|------------|------------------|
                               // | San Franscisco | 25     | 15     | 20         | Sunny            |
                               // | London         | 20     | 10     | 15         | Cloudy           |
                               // | São Paulo      | 23     | 18     | 20         | Rainy            |
                               // | Porto Alegre   | 30     | 20     | 28         | Sunny            |
                               
                               
                               
                               context("""
                                       WHEN    The app finishes loading
                                       """) {
                                           
                                           it( """
                                               THEN    the App should display four cities
                                               AND     their temperature, and forecast should be the following
                                               """) {
                                               // | City           | Max T. | Min T. | Current T. | Current Forecast |
                                               // |----------------|--------|--------|------------|------------------|
                                               // | San Franscisco | 25     | 15     | 20         | Sunny            |
                                               // | London         | 20     | 10     | 15         | Cloudy           |
                                               // | São Paulo      | 23     | 18     | 20         | Rainy            |
                                               // | Porto Alegre   | 30     | 20     | 28         | Sunny            |
                                           }
                                           
                               }
               }
               
               // MARK: - Scenario 3 - Failed to load weather
               describe(   """
                           GIVEN   the App is loading weather info for my prefered cities
                           AND     I am in the HomeScreen
                           AND     I am is not connected to the internet
                           """) {
                               
                               context("""
                                       WHEN    The app finishes loading
                                       """) {
                                       
                                       it( """
                                           THEN    the App should provide a 'Connection error' to the user
                                           AND     I should be in
                                           """) {
                                               
                                       }
                                       
                               }
               }
    }
}

