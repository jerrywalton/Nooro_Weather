//
//  CurrentWeather.swift
//  Nooro_Weather
//
//  Created by Jerry Walton on 12/23/24.
//

struct CurrentWeather: Codable {
    let temp_c: Double
    let condition: Condition
    let humidity: Int
    let uv: Double
    let feelslike_c: Double
}
