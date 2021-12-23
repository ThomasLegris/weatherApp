//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import Moya
import RxSwift
import RxMoya
import Foundation

/// Weather Api manager which uses Moya framework.
final class WeatherApiManager {
    // MARK: - Public Properties
    static let shared: WeatherApiManager = WeatherApiManager()

    /// Returns the Open Weather Map API Key.
    var apiKey: String {
        // Find Api plist file.
        guard let filePath = Bundle.main.path(forResource: "MyWeatherApp-info", ofType: "plist") else {
            fatalError("No API plist file")
        }

        // Find the Api key.
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "api_key") as? String else {
            fatalError("No api_key for OWMap")
        }
        return value
    }

    // MARK: - Private Properties
    /// Moya's service to use for each API request.
    private var weatherService = MoyaProvider<WeatherService>()

    // MARK: - Init
    private init() { }
}

// MARK: - WeatherApi
extension WeatherApiManager: WeatherApi {
    func cityWeather(cityName: String) -> Single<LocalWeatherResponse> {
        return weatherService.rx
            .request(.currentWeather(cityName: cityName))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(LocalWeatherResponse.self)
    }

    func locationWeather(latitude: Double,
                         longitude: Double) -> Single<LocalWeatherResponse> {
        weatherService.rx
            .request(.weatherByCoordinate(lat: latitude, long: longitude))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(LocalWeatherResponse.self)
    }

    func cityDetailsWeather(cityName: String) -> Single<DailyDetailsResponse> {
        weatherService.rx
            .request(.currentWeather(cityName: cityName))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(DailyDetailsResponse.self)
    }

    func cityWeeklyWeather(cityName: String) -> Single<WeeklyDetailsResponse> {
        weatherService.rx
            .request(.weeklyWeather(cityName: cityName))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(WeeklyDetailsResponse.self)
    }
}
