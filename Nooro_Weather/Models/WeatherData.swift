//
//  WeartherData.swift
//  Nooro_Weather
//
//  Created by Jerry Walton on 12/23/24.
//

struct WeatherData: Codable {
    let location: Location
    let current: CurrentWeather
}
