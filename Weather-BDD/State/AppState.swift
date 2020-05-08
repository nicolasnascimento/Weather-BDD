//
//  AppState.swift
//  Weather-BDD
//
//  Created by Nicolas Nascimento on 07/05/20.
//  Copyright © 2020 Nicolas Nascimento. All rights reserved.
//

import Foundation

struct AppState {
    enum Status {
        case loadingForecast
        case loadedForecasts
    }
    var status: Status
    var forecasts: [Forecast] = []
}

