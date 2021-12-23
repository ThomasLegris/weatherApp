// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Error
  internal static let commonError = L10n.tr("Localizable", "commonError")
  /// Ok
  internal static let commonOk = L10n.tr("Localizable", "commonOk")
  /// Daily
  internal static let dailyDetails = L10n.tr("Localizable", "dailyDetails")
  /// -
  internal static let dash = L10n.tr("Localizable", "dash")
  /// Can't update weather info
  internal static let errorNoInfo = L10n.tr("Localizable", "errorNoInfo")
  /// No Internet
  internal static let errorNoInternet = L10n.tr("Localizable", "errorNoInternet")
  /// Unknown city
  internal static let errorUnknownCity = L10n.tr("Localizable", "errorUnknownCity")
  /// Unknown location
  internal static let errorUnknownLocation = L10n.tr("Localizable", "errorUnknownLocation")
  /// Favorite cities
  internal static let favoriteList = L10n.tr("Localizable", "favoriteList")
  /// Home
  internal static let home = L10n.tr("Localizable", "home")
  /// Humidity
  internal static let humidity = L10n.tr("Localizable", "humidity")
  /// Can't find user location
  internal static let locationErrorMessage = L10n.tr("Localizable", "locationErrorMessage")
  /// Location Error
  internal static let locationErrorTitle = L10n.tr("Localizable", "locationErrorTitle")
  /// Map
  internal static let map = L10n.tr("Localizable", "map")
  /// %%
  internal static let percentUnit = L10n.tr("Localizable", "percentUnit")
  /// km/h
  internal static let speedUnit = L10n.tr("Localizable", "speedUnit")
  /// Sunrise
  internal static let sunrise = L10n.tr("Localizable", "sunrise")
  /// Sunset
  internal static let sunset = L10n.tr("Localizable", "sunset")
  /// Weather details
  internal static let weatherDetails = L10n.tr("Localizable", "weatherDetails")
  /// Weekly
  internal static let weeklyDetails = L10n.tr("Localizable", "weeklyDetails")
  /// Wind
  internal static let wind = L10n.tr("Localizable", "wind")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
