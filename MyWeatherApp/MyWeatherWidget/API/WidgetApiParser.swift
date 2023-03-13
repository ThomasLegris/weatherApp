//
//  WidgetApiParser.swift
//  MyWeatherWidgetExtension
//
//  Created by Thomas Legris on 10/03/2023.
//  Copyright © 2023 Thomas LEGRIS. All rights reserved.
//

import Foundation

/// Files which provides several OpenWeatherMap response models.

// MARK: - Structs
/// Model for a city weather response.
struct LocalWeatherResponse: Codable {
    // MARK: - Public Properties
    var weather: [WeatherField]?
    var main: MainField
    var name: String

    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case name
    }
}

/// Model for the `weather` field in the JSON Response.
struct WeatherField: Codable {
    var identifier: Int
    var main: String
    var description: String
    var icon: String

    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case main
        case description
        case icon
    }
}

/// Model for the `main` field in the JSON Response.
struct MainField: Codable {
    var temp: Float
    var pressure: Float
    var humidity: Float
    var tempMin: Float
    var tempMax: Float

    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
