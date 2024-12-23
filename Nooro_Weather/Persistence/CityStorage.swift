//
//  CityStorage.swift
//  Nooro_Weather
//
//  Created by Jerry Walton on 12/23/24.
//
import Foundation

class CityStorage {
    private let cityKey = "selectedCity"

    func saveCity(_ city: String) {
        UserDefaults.standard.set(city, forKey: cityKey)
    }

    func getSavedCity() -> String? {
        UserDefaults.standard.string(forKey: cityKey)
    }
}
