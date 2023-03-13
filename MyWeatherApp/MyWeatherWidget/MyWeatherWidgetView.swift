//
//  MyWeatherWidgetView.swift
//  MyWeatherWidgetExtension
//
//  Created by Thomas Legris on 22/02/2023.
//  Copyright © 2023 Thomas LEGRIS. All rights reserved.
//

import Foundation
import SwiftUI
import WidgetKit
import OSLog

/// Main view of the widget.
struct MyWeatherWidgetEntryView: View {
    var entry: MyWeatherWidgetEntry
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 4.0) {
            
            HStack(alignment: .center, spacing: 2.0) {
                Text(entry.city)
                    .lineLimit(2)
                    .font(.headline)
                    .truncationMode(.tail)
                    .font(.headline)
                Spacer()
                Text(entry.date, style: .time)
                    .font(.caption)
                    .foregroundColor(Color.blue)
                    .frame(maxWidth: 52.0)
            }.padding(12.0)
            Spacer()
            Image(entry.iconName)
            Spacer()
            HStack(alignment: .center, spacing: 2.0) {
                Text(entry.description)
                    .font(.callout)
                Text("|").foregroundColor(Color.gray)
                Text("\(Int(entry.temperature))°")
                    .font(.callout)
            }.padding(12.0)
        }
    }
}
