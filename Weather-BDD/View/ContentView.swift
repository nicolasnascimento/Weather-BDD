//
//  ContentView.swift
//  Weather-BDD
//
//  Created by Nicolas Nascimento on 04/05/20.
//  Copyright © 2020 Nicolas Nascimento. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var state: AppState
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.state.forecasts) { forecast in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(forecast.cityName) - \(Int(forecast.currentTemp.rounded()))º")
                                .font(.system(size: 17))
                                .foregroundColor(Color.black)
                            Text("\(Int(forecast.minTemp.rounded()))º - \(Int(forecast.maxTemp))º")
                                .font(.system(size: 15))
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                        Image(systemName: forecast.currentForecast == "Sunny" ? "sun.max.fill" : "cloud.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 38, height: 38, alignment: .center)
                    }
                }
            }.navigationBarTitle("Forecasts")
        }
    }
}

extension Forecast: Identifiable {
    var id: String { return cityName }
}
