//
//  MyWeatherWidget.swift
//  MyWeatherWidget
//
//  Created by Thomas Legris on 15/02/2023.
//  Copyright © 2023 Thomas LEGRIS. All rights reserved.
//

import WidgetKit
import SwiftUI

/// Configuration widget.
struct MyWeatherWidget: Widget {
    private let kind: String = "MyWeatherWidget"
    
    var body: some WidgetConfiguration {
        /// Decris un widget qui sera affiché selon une certaine timeline (fourni par le provider).
        /// WeatherProvider instancie la timeline (à des différentes dates). C'est simplement la configuration.
        StaticConfiguration(kind: kind,
                            provider: MyWeatherWidgetProvider()) { entry in
            /// Instancie la view que l'on veut.
            MyWeatherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemLarge])
    }
}
