//
//  MyWeatherWidgetEntry.swift
//  MyWeatherApp
//
//  Created by Thomas Legris on 22/02/2023.
//  Copyright © 2023 Thomas LEGRIS. All rights reserved.
//

import Foundation
import WidgetKit

// Model which represents the content of WeatherWidget`
struct MyWeatherWidgetEntry: TimelineEntry {
    var date: Date
    var city: String
    var temperature: Float
    var description: String
    var iconName: String
}
