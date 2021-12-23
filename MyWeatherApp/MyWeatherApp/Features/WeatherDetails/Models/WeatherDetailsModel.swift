//
//  Copyright (C) 2020 Thomas LEGRIS.
//

// MARK: - Structs
/// Model used for daily details view.
struct DailyDetailsModel {
    // MARK: - Public Properties
    var humidity: String?
    var wind: String?
    var sunset: String?
    var sunrise: String?
}

/// Model used for daily details view.
struct WeeklyDetailsModel {
    // MARK: - Public Properties
    var list: [DailyWeather]
}
