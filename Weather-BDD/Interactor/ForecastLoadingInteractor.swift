//
//  ForecastLoadingInteractor.swift
//  Weather-BDD
//
//  Created by Nicolas Nascimento on 07/05/20.
//  Copyright © 2020 Nicolas Nascimento. All rights reserved.
//

import Foundation
import Combine

protocol ForecastProvider {
    func getForecasts() -> AnyPublisher<[Forecast], Error>
}

struct ForecastLoadingInteractor {
    var forecastProvider: ForecastProvider
}

extension ForecastLoadingInteractor {
    func perform(action: Action, in: AppState) -> AnyPublisher<[Forecast], Error> {
        forecastProvider
            .getForecasts()
            .map{ $0.sorted{ $0.cityName < $1.cityName } }
            .eraseToAnyPublisher()
    }
}

extension ForecastLoadingInteractor {
    enum Action {
        case load
    }
    enum Errors: Error {
        case unknown
    }
}

