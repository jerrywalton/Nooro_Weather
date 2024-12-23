//
//  Nooro_WeatherApp.swift
//  Nooro_Weather
//
//  Created by Jerry Walton on 12/23/24.
//

import SwiftUI
import SwiftData

@main
struct Nooro_WeatherApp: App {
    @StateObject private var viewModel = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .environmentObject(viewModel)
    }
}
