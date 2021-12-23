//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import Foundation

/// Files which provides several OpenWeatherMap response models.
/// Only used for details screen.

// MARK: - Structs
/// Model for a city weather response.
struct DailyDetailsResponse: Codable {
    var main: MainField
    var wind: WindField
    var sys: SysField

    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case main
        case wind
        case sys
    }

    // MARK: - Private Enums
    private enum Constants {
        static let format: String = "HH:mm a"
    }
}

// MARK: - Public Properties
extension DailyDetailsResponse {
    /// Returns a model for daily details weather built with self.
    var dailyDetailsModel: DailyDetailsModel? {
        let sunsetTimeInterval = TimeInterval(self.sys.sunset)
        let sunriseTimeInterval = TimeInterval(self.sys.sunrise)
        let sunsetDate = Date(timeIntervalSince1970: sunsetTimeInterval)
        let sunriseDate = Date(timeIntervalSince1970: sunriseTimeInterval)

        return DailyDetailsModel(humidity: "\(self.main.humidity)",
                                 wind: "\(self.wind.speed)",
                                 sunset: sunsetDate.formattedDate(with: Constants.format),
                                 sunrise: sunriseDate.formattedDate(with: Constants.format))
    }
}

/// Model for the `wind` field in the JSON Response.
struct WindField: Codable {
    var speed: Float

    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case speed
    }
}

/// Model for the `sys` field in the JSON Response.
struct SysField: Codable {
    var sunrise: Int
    var sunset: Int

    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case sunrise
        case sunset
    }
}

// MARK: - Weekly
/// Model for a city weather response.
struct WeeklyDetailsResponse: Codable {
    // MARK: - Public Properties
    var list: [DailyWeather]

    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case list
    }
}

// MARK: - Public Properties
extension WeeklyDetailsResponse {
    /// Returns a model about weekly weather.
    var weeklyDetailsModel: WeeklyDetailsModel? {
        return WeeklyDetailsModel(list: self.list)
    }
}

/// Model for the `list` field in the JSON Response.
struct DailyWeather: Codable {
    /// Date of the current field.
    var date: Int
    /// Main field.
    var main: MainField
    /// Weather field.
    var weather: [WeatherField]

    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
    }
}
