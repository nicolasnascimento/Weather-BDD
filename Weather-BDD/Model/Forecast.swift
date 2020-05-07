//
//  Forecast.swift
//  Weather-BDD
//
//  Created by Nicolas Nascimento on 07/05/20.
//  Copyright © 2020 Nicolas Nascimento. All rights reserved.
//

import Foundation

struct Forecast: Equatable {
    var cityName: String
    var currentForecast: String
    var currentTemp: Double
    var minTemp: Double
    var maxTemp: Double
}

