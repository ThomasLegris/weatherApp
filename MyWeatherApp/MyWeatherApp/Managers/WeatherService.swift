//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import RxMoya
import Moya
import Foundation

// MARK: - Public Enums
/// Moya service for weather API.
enum WeatherService {
    /// Gets current weather with city name.
    case currentWeather(cityName: String)
    /// Get weather by coordinate.
    case weatherByCoordinate(lat: Double, long: Double)
    /// Gets weekly weather with city name.
    case weeklyWeather(cityName: String)
}

// MARK: - Private Enums
private extension WeatherService {
    /// Provides common constants.
    enum Constants {
        static let baseUrl: String = "https://api.openweathermap.org/data/2.5/"
        static let tempUnit: String = "metric"
        static let cityParam: String = "q"
        static let unitsParam: String = "units"
        static let keyParam: String = "appid"
        static let latParam: String = "lat"
        static let longParam: String = "lon"
    }
}

// MARK: - TargetType
extension WeatherService: TargetType {
    var baseURL: URL {
        return URL(string: Constants.baseUrl)!
    }

    var path: String {
        switch self {
        case .currentWeather,
             .weatherByCoordinate:
            return "weather"
        case .weeklyWeather:
            return "forecast"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return "data".data(using: .utf8)!
    }

    var task: Task {
        switch self {
        case .currentWeather(cityName: let city),
             .weeklyWeather(cityName: let city):
            return .requestParameters(parameters: [Constants.cityParam: city,
                                                   Constants.unitsParam: Constants.tempUnit,
                                                   Constants.keyParam: WeatherApiManager.shared.apiKey],
                                      encoding: URLEncoding.queryString)
        case .weatherByCoordinate(lat: let lat, long: let long):
            return .requestParameters(parameters: [Constants.latParam: lat,
                                                   Constants.longParam: long,
                                                   Constants.unitsParam: Constants.tempUnit,
                                                   Constants.keyParam: WeatherApiManager.shared.apiKey],
                                      encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
