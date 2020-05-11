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


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        
        let apiKey = "YOUR_API_KEY"
        let provider = OpenWeatherForecastProvider(apiKey: apiKey, cityNames: ["San Francisco", "Porto Alegre"])
        let interactor = ForecastLoadingInteractor(forecastProvider: provider)
        
        self.cancellable = interactor
            .perform(action: .load, in: state)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in } ) { self.state.forecasts = $0 }
        
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

