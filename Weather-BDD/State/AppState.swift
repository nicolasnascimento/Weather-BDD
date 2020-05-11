//
//  AppState.swift
//  Weather-BDD
//
//  Created by Nicolas Nascimento on 07/05/20.
//  Copyright © 2020 Nicolas Nascimento. All rights reserved.
//

import Foundation

final class AppState: ObservableObject {
    enum Status {
        case loadingForecast
        case loadedForecasts
    }
    @Published var status: Status
    @Published var forecasts: [Forecast]
    
    init(status: Status, forecasts: [Forecast] = []) {
        self.status = status
        self.forecasts = forecasts
    }
}

