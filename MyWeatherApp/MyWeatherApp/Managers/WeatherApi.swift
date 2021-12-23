//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import Foundation
import RxSwift

// MARK: - Protocols
/// Defines weather API methods.
protocol WeatherApi {
    /// Gets global weather by city.
    ///
    /// - Parameters:
    ///     - cityName: name of targetted city
    /// - Returns: A single element sequence with local response.
    func cityWeather(cityName: String) -> Single<LocalWeatherResponse>

    /// Gets global weather by coordinates.
    ///
    /// - Parameters:
    ///     - latitude: latitude
    ///     - longitude: longitude
    /// - Returns: A single element sequence with local response.
    func locationWeather(latitude: Double, longitude: Double) -> Single<LocalWeatherResponse>

    /// Gets details weather.
    ///
    /// - Parameters:
    ///     - cityName: name of targetted city
    /// - Returns: A single element sequence with details response.
    func cityDetailsWeather(cityName: String) -> Single<DailyDetailsResponse>

    /// Gets next week weather.
    ///
    /// - Parameters:
    ///     - cityName: name of targetted city
    /// - Returns: A single element sequence with weekly weather response.
    func cityWeeklyWeather(cityName: String) -> Single<WeeklyDetailsResponse>
}
