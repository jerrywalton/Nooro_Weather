//
//  WeatherService.swift
//  Nooro_Weather
//
//  Created by Jerry Walton on 12/23/24.
//
import Foundation

protocol WeatherAPI {
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void)
}

class WeatherService: WeatherAPI {
    private let apiKey = "998b3b39d426464dbe9125521241612"
    private let baseURL = "https://api.weatherapi.com/v1/current.json"

    func fetchWeather(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)?key=\(apiKey)&q=\(city)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }

            do {
                print(String(data: data, encoding: .utf8)!)
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                print(weatherData)
                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
