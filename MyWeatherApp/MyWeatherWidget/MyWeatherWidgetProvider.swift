//
//  MyWeatherWidgetProvider.swift
//  MyWeatherApp
//
//  Created by Thomas Legris on 13/03/2023.
//  Copyright © 2023 Thomas LEGRIS. All rights reserved.
//

import Foundation
import WidgetKit
import OSLog

/// The weather widget provider.
struct MyWeatherWidgetProvider: TimelineProvider {
    // MARK: - Private Properties
    private let manager = WidgetApiManager()
    private var lastUpdateTime = Date()
    private let snapshotEntry =  MyWeatherWidgetEntry(date: Date(),
                                                      city: "City",
                                                      temperature: 0.0,
                                                      description: "-",
                                                      iconName: "01d")
    
    // MARK: - Funcs
    func placeholder(in context: Context) -> MyWeatherWidgetEntry {
        MyWeatherWidgetEntry(date: Date(),
                             city: "City",
                             temperature: 0.0,
                             description: "-",
                             iconName: "01d")
    }
    
    /// Timeline preview in Gallery.
    func getSnapshot(in context: Context, completion: @escaping (MyWeatherWidgetEntry) -> ()) {
        let entry = snapshotEntry
        completion(entry)
    }
    
    /// Timeline instance which defines specific dates to update the widget.
    func getTimeline(in context: Context, completion: @escaping (Timeline<MyWeatherWidgetEntry>) -> ()) {
        var entries: [MyWeatherWidgetEntry] = []
        let firstEntry = MyWeatherWidgetEntry(date: Date(), city: "Unkown", temperature: 0.0, description: "-", iconName: "")
        
        entries.append(firstEntry)
        
        manager.requestDailyWeather { model, error in
            guard let newEntry = model else { return }
            os_log("Widget requested weather info", log: OSLog.default, type: .info)
            entries.append(newEntry)
            
            // Update refresh date (each 60 min).
            if let refreshDate = Calendar.current.date(byAdding: .minute, value: 60, to: Date()) {
                // Create the timeline with entries and the newly created refresh date.
                let timeline = Timeline(entries: entries, policy: .after(refreshDate))
                completion(timeline)
            }
        }
    }
}
