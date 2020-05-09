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

extension Forecast {
    static func ==(lhs: Forecast, rhs: Forecast) -> Bool {
        return lhs.cityName == rhs.cityName
            && lhs.currentForecast == rhs.currentForecast
            && Int(lhs.currentTemp*100) == Int(rhs.currentTemp*100)
            && Int(lhs.minTemp*100) == Int(rhs.minTemp*100)
            && Int(lhs.maxTemp*100) == Int(rhs.maxTemp*100)
    }
}

