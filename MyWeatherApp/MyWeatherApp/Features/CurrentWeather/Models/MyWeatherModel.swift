//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit

// MARK: - Structs
/// Model used for updating the custom widget view.
struct CommonWeatherModel: Equatable {
    // MARK: - Public Properties
    var temperature: Float?
    var icon: UIImage?
    var description: String?
    var cityName: String?
}

// MARK: - Public Enums
/// Provides different weather description.
enum WeatherGroup {
    case thunder
    case drizzle
    case rain
    case snow
    case atmosphere
    case clear
    case clouds

    /// Icon corresponding to the current weather description.
    var icon: UIImage {
        switch self {
        case .thunder:
            return Asset.icThunder.image
        case .rain,
             .drizzle:
            return Asset.icRain.image
        case .snow:
            return Asset.icSnow.image
        case .atmosphere:
            return Asset.icFog.image
        case .clear:
            return Asset.icSun.image
        case .clouds:
            return Asset.icSunCloudy.image
        }
    }
}

/// Stores different weather request error.
enum WeatherError {
    case noInternet
    case noInfo
    case unknownCity
    case none

    /// Error's title.
    var title: String {
        return L10n.commonError
    }

    /// Error's message.
    var message: String {
        switch self {
        case .noInternet:
            return L10n.errorNoInternet
        case .unknownCity:
            return L10n.errorUnknownCity
        default:
            return L10n.errorNoInfo
        }
    }
}
