//
//  SceneDelegate.swift
//  Weather-BDD
//
//  Created by Nicolas Nascimento on 04/05/20.
//  Copyright © 2020 Nicolas Nascimento. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var cancellable: AnyCancellable?
    var state = AppState(status: .loadingForecast)


    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        // Create Interactor
        let apiKey = "YOUR_API_KEY"
        let provider = OpenWeatherForecastProvider(apiKey: apiKey, cityNames: ["San Francisco", "Porto Alegre"])
        let interactor = ForecastLoadingInteractor(forecastProvider: provider)
        
        // Perform the request only if we are not testing
        if CommandLine.arguments.contains("--UITESTING") {
            let testingForecasts: [Forecast] = [
                .init(cityName: "Porto Alegre", currentForecast: "Cloudy", currentTemp: 15, minTemp: 10, maxTemp: 20),
                .init(cityName: "San Francisco", currentForecast: "Sunny", currentTemp: 20, minTemp: 15, maxTemp: 25)
            ]
            self.state.forecasts = testingForecasts
            
        } else {
            self.cancellable = interactor
                .perform(action: .load, in: state)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { _ in } ) { self.state.forecasts = $0 }
        }
        
        // Share AppState among SwiftUI Views
        let contentView = ContentView()
            .environmentObject(state)

        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

