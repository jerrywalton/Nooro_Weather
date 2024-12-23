//
//  HomeViewModel.swift
//  Nooro_Weather
//
//  Created by Jerry Walton on 12/23/24.
//
import Dispatch
import Combine

final class HomeViewModel: ObservableObject {
    @Published var cityWeather: WeatherData?
    @Published var searchResults: WeatherData?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    private let weatherService: WeatherAPI
    private let cityStorage: CityStorage

    init(weatherService: WeatherAPI = WeatherService(), cityStorage: CityStorage = CityStorage()) {
        self.weatherService = weatherService
        self.cityStorage = cityStorage
        loadSavedCityWeather()
    }

    func loadSavedCityWeather() {
        guard let savedCity = cityStorage.getSavedCity() else { return }
        fetchWeather(for: savedCity)
    }
    
    func saveCityWeather() {
        guard let cityName = cityWeather?.location.name else { return }
        cityStorage.saveCity(cityName)
    }
    
    func searchWeather(for city: String) {
        isLoading = true
        weatherService.fetchWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let weather):
                    self?.searchResults = weather
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func fetchWeather(for city: String) {
        isLoading = true
        weatherService.fetchWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let weather):
                    self?.cityWeather = weather
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

}
