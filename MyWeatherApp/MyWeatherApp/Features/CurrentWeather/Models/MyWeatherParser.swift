//
//  Copyright (C) 2020 Thomas LEGRIS.
//

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

    // MARK: - Public Properties
    /// Returns a Common weather model built with self.
    var commonWeatherModel: CommonWeatherModel? {
        guard let weather = weather?[0] else { return CommonWeatherModel(temperature: 0.0,
                                                                         icon: Asset.icSun.image,
                                                                         description: "",
                                                                         cityName: "") }

        let weatherModel: CommonWeatherModel = CommonWeatherModel(temperature: main.temp,
                                                                  icon: self.groupFromId(identifier: weather.identifier).icon,
                                                                  description: weather.main,
                                                                  cityName: name)
        return weatherModel
    }
}

// MARK: - Private Funcs
private extension LocalWeatherResponse {
    /// Get weather group according to id.
    ///
    /// - Parameters:
    ///     - identifier: weather call response identifier
    /// - Returns: A weather group associated to its id.
    func groupFromId(identifier: Int) -> WeatherGroup {
        switch identifier {
        case 200...232:
            return .thunder
        case 300...321:
            return .drizzle
        case 500...531:
            return .rain
        case 600...622:
            return .snow
        case 701...781:
            return .atmosphere
        case 800:
            return .clear
        default:
            return .clouds
        }
    }
}

/// Model for the `weather` field in the JSON Response.
struct WeatherField: Codable {
    var identifier: Int
    var main: String
    var icon: String

    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case main
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
